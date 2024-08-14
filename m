Return-Path: <netdev+bounces-118557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F249520B9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811951F2288E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74631BB69B;
	Wed, 14 Aug 2024 17:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38B4502B;
	Wed, 14 Aug 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655416; cv=none; b=E/mfpC/YdKTqEjuv/mMSFVCpZc50HBGGlHEAnnDAE431MTNGkjPc6V1eYFhs8CsCyQky24oZu0/RcAskCwM1luAAeuiBMJSx6totqz9m0OKDXcYg3qFPhpL8bDWP7LPtCV906ee9lVZbApV08FUcObO/jVLVBfRCl2/ez94fCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655416; c=relaxed/simple;
	bh=F4XPMawEpVXT9q7pRj4NtWJkjyAA81vm0rr2VpJL9tI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mTogRPGrgwhfOMQMXDYcSo4WrcQDQ4MM8GxE5rqdZSzkH2WfQaCleIgUB/xy8bUHAhPdyFwmS0ebggLUEf5ZWxgVHxnYkoKfROrjMMcjM2VoU7Um7bMvow5YMMH+dWngJZkMQnj8n+NssV0jiL8DIlzyI7Dh/m37YC3dzEeL68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f032cb782dso1068431fa.3;
        Wed, 14 Aug 2024 10:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655413; x=1724260213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sP0prdJ764zDRhGrMOxeD1PYZLi3P8WVzp9dTBreHs=;
        b=JGhbgY8mtlubOMfvtFbBlXKCr3VDxVCUGuNctqVOLPLslG00L3L3FwcpVf+RQCu+mK
         X03J2fCIUGfd4hZUgI/vL+7rFz+2wkXj1RgqISQKWw8ykKYax8jWsGd9WU/seemDSdbN
         2uwCJaxj2GJ0r2Xjr2/fDEM8RAwyK+CjC1CwYfU0dsqWNfeSoyvxWvzLyt/yAPYv6QzQ
         5Xmha5DyuvTrTfYloVeIPYDBAsNmsuC2SfR8S8MSe9yxEASVfVfbMoRs1roNhXvJVhF2
         V5VVxNQEYj4mQb7AX0VRWoxmvMP+2jTuJUml7z9W6137QooWidGcNc7rHmm13puML/XV
         +g3g==
X-Forwarded-Encrypted: i=1; AJvYcCXi273ST6BSjrT914G6mloFY6MiI6iV0FbBiTrU9gk6vwj3y6sP4QDtEPED1Cv27VBtyRBwPUKflleyyy3IzlPBtL6JqNpiW6+s3rV/7W7BrE3J/ulNt+U9hM9xOCEaZ0ZfQb+L9+7c
X-Gm-Message-State: AOJu0YxADe2Q+5EBti77PvUKzzotUD0KZ/+EuohlnUYIl+VSVe9rXAW4
	zkCsaJHlgifyW7Tn+94DbULVO0Z598xFf+7/RD023uTlnHJeUfvn
X-Google-Smtp-Source: AGHT+IH8Z01+eFXbFBwCYnLygKYJO8nh4RI5+IJx3TWPFQdiMFkE4hEKhkA7azYW55nofQIrBXQquw==
X-Received: by 2002:a2e:a99f:0:b0:2ee:7dfe:d99c with SMTP id 38308e7fff4ca-2f3aa1f51a3mr23695561fa.31.1723655412783;
        Wed, 14 Aug 2024 10:10:12 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5be9bb73800sm1569528a12.38.2024.08.14.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:10:12 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:10:10 -0700
From: Breno Leitao <leitao@debian.org>
To: kees@kernel.org, elver@google.com, andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com
Cc: kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	axboe@kernel.dk, asml.silence@gmail.com, netdev@vger.kernel.org
Subject: UBSAN: annotation to skip sanitization in variable that will wrap
Message-ID: <Zrzk8hilADAj+QTg@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am seeing some signed-integer-overflow in percpu reference counters.

	UBSAN: signed-integer-overflow in ./arch/arm64/include/asm/atomic_lse.h:204:1
	-9223372036854775808 - 1 cannot be represented in type 's64' (aka 'long long')
	Call trace:

	 handle_overflow
	 __ubsan_handle_sub_overflow
	 percpu_ref_put_many
	 css_put
	 cgroup_sk_free
	 __sk_destruct
	 __sk_free
	 sk_free
	 unix_release_sock
	 unix_release
	 sock_close

This overflow is probably happening in percpu_ref->percpu_ref_data->count.

Looking at the code documentation, it seems that overflows are fine in
per-cpu values. The lib/percpu-refcount.c code comment says:

 * Note that the counter on a particular cpu can (and will) wrap - this
 * is fine, when we go to shutdown the percpu counters will all sum to
 * the correct value

Is there a way to annotate the code to tell UBSAN that this overflow is
expected and it shouldn't be reported?

Thanks
--breno


