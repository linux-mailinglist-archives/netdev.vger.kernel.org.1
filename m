Return-Path: <netdev+bounces-123454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AAF964ECB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F071C2303D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84D1B9B44;
	Thu, 29 Aug 2024 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="iyxOwQft"
X-Original-To: netdev@vger.kernel.org
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D83AC28;
	Thu, 29 Aug 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959638; cv=none; b=XZcDbnYQOocWbSVd/3VvmGNlg/UsPBYFbMmy5lKVC49+1pFDi+m/j2YT3pFBcBS+2cqmcg+nRdqngZv3H60WeQU5iI/39o6YBYjOqmL23XNMYbFfyY9W8zp+/7yV77y790p3D1P2Hw/Y24ibbPHfLTeAkvOH2DgcTzqVMiXzysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959638; c=relaxed/simple;
	bh=tsa65pvZJDD6R4EM4kwdUAwA1p2t4Jmyl08tvKxO4c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUdKz2TLZwwx7CpvQgVzRQTIFAQN46OBJTvdvAL+bKjW9OJeoFrmdxrkzQbxR4mZY21Ie4WD/sUmfkhzOnZIzUiAPGu1R+FY2h5SWcjg4HUBfreFN1H2cCHMHWbEPc+pjcADzYkGdTY3Bz0MGmPuWWMxBGvT4MuS6Aix3E3HzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=iyxOwQft; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QrhCT7icu6NtnGgnTVANA9HRX8TTQ+yDYH4sT/SdKxU=; b=iyxOwQftMHbfTt+tYbSYAAPFku
	2tb2UF+TYVS8rBE271UdtFJqGwpG7izlnirE4eAcAO/mMt1XlbJB8Cv/WyOQudLdYSRh4YnacYQu4
	+yLncnJJNQqUTGubW1X5tS7gYoDTKbCBFk0ogTLH27FnCJ01toySVYoLd9Ry+nYENcwU=;
Received: from [88.117.52.244] (helo=[10.0.0.160])
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sjknM-0003tY-0W;
	Thu, 29 Aug 2024 21:27:00 +0200
Message-ID: <23021c75-3dcb-404c-bf79-cef583f4600a@engleder-embedded.com>
Date: Thu, 29 Aug 2024 21:26:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igc: Unlock on error in igc_io_resume()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Sasha Neftin <sasha.neftin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <64a982d3-a2f5-4ef7-ad75-61f6bb1fae24@stanley.mountain>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <64a982d3-a2f5-4ef7-ad75-61f6bb1fae24@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 29.08.24 21:22, Dan Carpenter wrote:
> Call rtnl_unlock() on this error path, before returning.
> 
> Fixes: bc23aa949aeb ("igc: Add pcie error handler support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index dfd6c00b4205..0a095cdea4fb 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7413,6 +7413,7 @@ static void igc_io_resume(struct pci_dev *pdev)
>   	rtnl_lock();
>   	if (netif_running(netdev)) {
>   		if (igc_open(netdev)) {
> +			rtnl_unlock();
>   			netdev_err(netdev, "igc_open failed after reset\n");
>   			return;
>   		}

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

