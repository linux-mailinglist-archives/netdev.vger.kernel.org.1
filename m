Return-Path: <netdev+bounces-65899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF1383C41C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 14:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0441F26BDB
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474055A7B1;
	Thu, 25 Jan 2024 13:50:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21DB5B202;
	Thu, 25 Jan 2024 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190651; cv=none; b=h1Nhqq3i9huB8aT4eRjn8mSJB7rTrthAoG1Rzlnaek6rRkLPEwh7yKbC8glAU9icelaqjJfISbpcbo+aezqKpV1jmnPgkWRfEM1i6ldbbdlfhnSHEVZGlXg1P/kJP/id7EEGkV4sGqJkSgkjaoyPBURK/W9VytdTASLlwuVDjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190651; c=relaxed/simple;
	bh=F/U5LhGNBmgteZeGVKoqIAELqkcV5qzrLt5Z3MmCb9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq5RJgPLNrAV+vZOE1qObv6thktGbHw9Bs6pWWy49GsC7Ds+Jd4gjCRf6n76BggyF6Ecj8vW6aCFoep0xm12Ye3k4uEcHKcYeI9Eqwo+/veri+RQr2aJv4nY/rxEQL+kNyioPBUNtXzVQ//pkkrPXT99v3eEf1VNzT1FVIAWeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28a6cef709so703628266b.1;
        Thu, 25 Jan 2024 05:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190648; x=1706795448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHBFo+pVlE6vUm8V2rDw0OyWPlmP6lAjan69MnX7bZ4=;
        b=KzE57ueBGvcd7SoTCEelmmpmFG/jSOkGuQ5WrGaaTMq56hPxmBOeQf3l+IQAvTqjvw
         p7NMfNiur1o00rvYHFVtV3h5Sd59cOBY148yUk7Bxv+BqtZLFdbMUSqpczRcpMKXtEbo
         YMYRWh600tmVMJuDwVGK+jK9LsmRqrWu9gIBpcRCeA8aVi+LePQqaSUtWrjkIc9cHHFv
         AC+uG3197Q12uzOVjkCCMzqiUsuqTg6X4E/jdQY/NXPenWTpt6H3tdaAJc+HpemhVstH
         JuTbsuQ28JZ02FqN+ehA5esVCseIDtyremQtVFqvhYQ3lxDY4R79xhNDsEBGbIcGrvYe
         LdrA==
X-Gm-Message-State: AOJu0Yxx/hZuT4lsillJPtl8uH/Gj9rQ65Tz/4Tn85uFlEo/bvwdElhQ
	uopwuhbFgWLrNwNrPpThHLvaNylh7MBfKCtN0gSAxUihvdZng4pZ
X-Google-Smtp-Source: AGHT+IENQs3qkbW6Z2O2Rx7IiRcujrk2SL8jPrIwcIHgjM9k8+74dxv+KUH+S67s2s6KGIgm0Oon/g==
X-Received: by 2002:a17:906:c8c8:b0:a2d:ad36:a7a7 with SMTP id gc8-20020a170906c8c800b00a2dad36a7a7mr470492ejb.154.1706190647466;
        Thu, 25 Jan 2024 05:50:47 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-009.fbsv.net. [2a03:2880:31ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id cu15-20020a170906ba8f00b00a318cb84525sm460471ejd.216.2024.01.25.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:50:47 -0800 (PST)
Date: Thu, 25 Jan 2024 05:50:45 -0800
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 01/12] tools/net/ynl: Add --output-json arg
 to ynl cli
Message-ID: <ZbJnNbX56eY3xcKK@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
 <20240123160538.172-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123160538.172-2-donald.hunter@gmail.com>

On Tue, Jan 23, 2024 at 04:05:27PM +0000, Donald Hunter wrote:
> The ynl cli currently emits python pretty printed structures which is
> hard to consume. Add a new --output-json argument to emit JSON.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

