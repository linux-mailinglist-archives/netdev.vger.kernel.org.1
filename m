Return-Path: <netdev+bounces-124713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C896A851
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC72855A0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C067D1AD274;
	Tue,  3 Sep 2024 20:28:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6E41C65
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395295; cv=none; b=a8WjWD4mAA2yJcBm7ph0Zno7zzkPiFWgBjr12ofyHMw/JeHExZXMD6LwPDea3yqjytTmyDFXXW2JkAPl4lNpTxPPtiKTpTxJN+XV+RTFCxsaG2/er27HZ62gR0qsxr/bFbllToAdh4v+/qtHTMRjyrfROQ/KcwA8AqOK/VR/eeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395295; c=relaxed/simple;
	bh=KnU6l4ZZ3A/4cgKPFWyN3+unIDz97dfInmkBH5KBjhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQXAFEsi4HHbYppC5+P9h1W9Abh/4qFsGbd5X6+Mowy9Dl+Y/UmX/NG2dbkA0By8EpYMRSI1Io+w1Ek6Sy09Bvqw+Dm5TeSNulwIgaduSVenDUYgJwrnhc9e8Lvk2q0dsBSfWq0W17I8YXQoHxd2hgEBIxONOp7ZbHGY5i8st6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2053616fa36so36593235ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 13:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725395293; x=1726000093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3A60OOjnxCAUNSVN8vw1GtE7dMjNUSpFy8/qJoQkW4=;
        b=BCCTESPjVmI8JRy5mSiRHUKuywXonEs1bZGdO6D53o27bLDnCUkPiJTjehUdhX5TIJ
         VYVmn/hksf59SsWIB2FjC7W+1V7QGZHBHNKA5LZX8Eug6bgac/CIUC97/D86fWU1Kj/Y
         zdv9swfiQ1A281xdAzGNUMLy8mzNMecG0dgnsGsxN0RoDgYTsQrUlfvoojUb6FP6C5Au
         n7F0JR2p+N3DTzbrI6J3pDlGzLPi0dbfdZ1hTwKgpJMVULhskXqNStQtaXB1UZOZRwjL
         fEuKMhEUVZk6/oDvCm/I6kGB2AG0SC7WydDDqsWuiqjwAqpg51+wR/XXoZ9jF/jf3KTj
         6+aQ==
X-Gm-Message-State: AOJu0Yw1TdX7nrLsJ2Fz7WwjKbEzvXYjtmBln2r9DLq2Hg5WbTLHjNbl
	2Vrxez1FWMQzZ0gfzHOOjiPsFLZZjUUGolMNCL4CqJB8wQHOCWk=
X-Google-Smtp-Source: AGHT+IE6f8AfWYvRx6JEMhfiakNkjafPNLEN5FPD+GVOEdA8loCEecMpzLrO5ff59YuqhZ7Dake3Yg==
X-Received: by 2002:a17:902:fc8f:b0:206:8c4a:7b73 with SMTP id d9443c01a7336-2068c4ae8b3mr42149335ad.50.1725395292735;
        Tue, 03 Sep 2024 13:28:12 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea58509sm2219135ad.223.2024.09.03.13.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 13:28:12 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:28:11 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, davem@davemloft.net
Subject: Re: [PATCH net] selftests: rtnetlink: add 'ethtool' as a dependency
Message-ID: <ZtdxW9v8oWt-Ows8@mini-arch>
References: <20240903151524.586614-1-anezbeda@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903151524.586614-1-anezbeda@redhat.com>

On 09/03, Ales Nezbeda wrote:
> Introduction of `kci_test_macsec_offload()` in `rtnetlink.sh` created
> a new dependency `ethtool` for the test suite. This dependency is not
> reflected in checks that run before all the tests, so if the `ethtool`
> is not present, all tests will start, but `macsec_offload` test will
> fail with a misleading message. Message would say that MACsec offload is
> not supported, yet it never actually managed to check this, since it
> needs the `ethtool` to do so.
> 
> Fixes: 3b5222e2ac57 ("selftests: rtnetlink: add MACsec offload tests")
> Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index bdf6f10d0558..fdd116458222 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -1306,6 +1306,7 @@ if [ "$(id -u)" -ne 0 ];then
>  	exit $ksft_skip
>  fi
>  
> +#check for dependencies
>  for x in ip tc;do
>  	$x -Version 2>/dev/null >/dev/null
>  	if [ $? -ne 0 ];then
> @@ -1313,6 +1314,11 @@ for x in ip tc;do
>  		exit $ksft_skip
>  	fi
>  done
> +ethtool --version 2>/dev/null >/dev/null
> +if [ $? -ne 0 ];then
> +	end_test "SKIP: Could not run test without the ethtool tool"
> +	exit $ksft_skip
> +fi

Can we use a 'require_command ethtool' (lib.sh helper) instead?

