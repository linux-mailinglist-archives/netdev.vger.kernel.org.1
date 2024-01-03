Return-Path: <netdev+bounces-61204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE19822DEA
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8685BB22DD9
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD261944C;
	Wed,  3 Jan 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmodyKMx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536F199A7
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28c0536806fso7636638a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 05:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704286813; x=1704891613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqXgQKmWJL+0Y56Ym1J0ReDHakNaewTonypkfLP84og=;
        b=AmodyKMxTCN8R5L70KKaJVBJ8PuoSTkEYc/TEr67YI85fw2seKk/JnDDmA6msRfEMx
         KnaRc62ZqWVUCuoinN16W5kuFzNV5IAO+yDc24peE/vBmx4s0HFUeq64r5YcJ6O/2p4G
         s3oyGQ46vbHqBFKwBOtrtt3SCTbMG5pgP/twsKxG6IngZwz9FxxOF1+N6ZnP0Wzfl3wO
         UlF7wzSy9/KAebcbgxyN/y3SOWI/JsdZZs+cOyV+wx1q0AerOTOkcpA66fsyVB1s7KNV
         ScpciE/Tw/iAxvRg1mmLboXWuB4fhRI6b7CCDk15r+7u7wTcq3gwxIPkVyVpPFs1th7q
         vp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286813; x=1704891613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqXgQKmWJL+0Y56Ym1J0ReDHakNaewTonypkfLP84og=;
        b=iKgR6KRdM1XrWNgmHY9LBxsQe3O0UhILNhWRlcLbU2w5Cy2u99gRnpE7Sms4Dlf5ng
         jcS30348EOY4hFbr+53AWgMMiZ1r10ZXTE0Jqg+C3uYqROOEP9MplDV2lKVy5K7zwvaR
         B3nLziHT19H+PbL8DLd6eVN10v60oVXaWGJqZf+KcvdSUYn9dJMCV8n8DqBgd8iteI0H
         I0fxe1waqQV34q9KjxZp/2F320jZXUl7ipZEGBLrkwXcSt8d+qh4FRQIjrmjsEj+ivIt
         N2TXlGFLWx528R9ibGRhGbZlFlhEw9gjrdBfAa1bBLKR/SnMIwmIe6UEjtbSECH4RU2l
         vPyw==
X-Gm-Message-State: AOJu0YxFnUTi8CvtcY16mFCR/VG88+YzLdcUym2m2qFER55r5f4AT1x0
	vJxAbVQhYuf3f0Y/VNNXziM=
X-Google-Smtp-Source: AGHT+IECvia1M5IRaUWoX/pwg44a8izsc2woZZKpZfaLsLxYKrBLXPZl9Q+gBDN0CAjMCtLQoFV06Q==
X-Received: by 2002:a17:90a:7a86:b0:28c:4b8c:9729 with SMTP id q6-20020a17090a7a8600b0028c4b8c9729mr7974246pjf.2.1704286812851;
        Wed, 03 Jan 2024 05:00:12 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id so2-20020a17090b1f8200b0028c940cdad8sm1631045pjb.5.2024.01.03.05.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:00:11 -0800 (PST)
Date: Wed, 3 Jan 2024 21:00:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface
 in a bond
Message-ID: <ZZVaVloICZPf8jiK@Laptop-X1>
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
 <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103094846.2397083-3-nicolas.dichtel@6wind.com>

On Wed, Jan 03, 2024 at 10:48:46AM +0100, Nicolas Dichtel wrote:
> +kci_test_enslave_bonding()
> +{
> +	local testns="testns"
> +	local bond="bond123"
> +	local dummy="dummy123"
> +	local ret=0
> +
> +	run_cmd ip netns add "$testns"
> +	if [ $? -ne 0 ]; then
> +		end_test "SKIP bonding tests: cannot add net namespace $testns"
> +		return $ksft_skip
> +	fi
> +
> +	# test native tunnel
> +	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr

Hi Nicolas,

The net-next added new function setup_ns in lib.sh and converted all hard code
netns setup. I think It may be good to post this patch set to net-next
to reduce future merge conflicts.

Jakub, Paolo, please correct me if we can't post fixes to net-next.

Thanks
Hangbin

