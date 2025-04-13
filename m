Return-Path: <netdev+bounces-181979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1F8A873E3
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3491D16BF67
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 20:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42171DE3CB;
	Sun, 13 Apr 2025 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fRhIt504"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DD78F4C;
	Sun, 13 Apr 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744577933; cv=none; b=qq3OPn/bYZktH04EaJvSZqh2SXDnbLucel4np/0av+eYTsjfID6DeZ2vdQqOC4gHgoA9qzLD2GflaDgl6enI4aBZleiRRZxFwEY6snQYPHRcMek32DzdR+npWT1f1uNVckNovYkxiooPEFf1L+Um9hiTVG+vaRNn9aoL1+t6rDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744577933; c=relaxed/simple;
	bh=E90JzzSXiY9GG5tjBOEoP/IwaOnrEZ+Qf4Tl3ya/RGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWdUhP8hrNTcUOIaJ0qXtFf+/ygl/YsdOu3L4BBUu6t4jW3ESSBkwIWrvyguqlHYXpVyqIc3ZAhKVyKD+KS6OXCcsWtAG3HNHmykhcFbqi7UnG/jrR+eDAm6yJBipsbWg4qcrQzK+RSR1Yo9oJQ4CapEgfI7ymMWmJphXFJZEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fRhIt504; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hU3mSUQlOPVbA387wMEw7maSg/WVdPBRYhXaApVuMtM=; b=fRhIt504PW6kOQuQOfazUSy29p
	TA7Aal6pKD+ROOdn3e5HBksRbbsiFqFLfRu99c+z51XW4VcPsKjsumIWkPpz3hafsndzp5pFJU20E
	Vl01P4VfseI6P2BxahLRwcHRRBJ5srmBwOGmrmdavg4GwG9EIgRwgv2RJqmYSt0OlGtA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u44Pb-0096B4-V2; Sun, 13 Apr 2025 22:58:43 +0200
Date: Sun, 13 Apr 2025 22:58:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net-next 2/3] ionic: support ethtool
 get_module_eeprom_by_page
Message-ID: <ed497741-9fcc-44fc-850d-5c018f2ef90e@lunn.ch>
References: <20250411182140.63158-1-shannon.nelson@amd.com>
 <20250411182140.63158-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411182140.63158-3-shannon.nelson@amd.com>

On Fri, Apr 11, 2025 at 11:21:39AM -0700, Shannon Nelson wrote:
> Add support for the newer get_module_eeprom_by_page interface.
> Only the upper half of the 256 byte page is available for
> reading, and the firmware puts the two sections into the
> extended sprom buffer, so a union is used over the extended
> sprom buffer to make clear which page is to be accessed.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  .../ethernet/pensando/ionic/ionic_ethtool.c   | 50 +++++++++++++++++++
>  .../net/ethernet/pensando/ionic/ionic_if.h    | 12 ++++-
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 66f172e28f8b..25dca4b36bcf 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -1052,6 +1052,55 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
>  	return err;
>  }
>  
> +static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
> +					   const struct ethtool_module_eeprom *page_data,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct ionic_lif *lif = netdev_priv(netdev);
> +	struct ionic_dev *idev = &lif->ionic->idev;
> +	u32 err = -EINVAL;
> +	u8 *src;
> +
> +	if (!page_data->length)
> +		return -EINVAL;
> +
> +	if (page_data->bank != 0) {
> +		NL_SET_ERR_MSG_MOD(extack, "Only bank 0 is supported");
> +		return -EINVAL;
> +	}
> +
> +	if (page_data->offset < 128 && page_data->page != 0) {
> +		NL_SET_ERR_MSG_MOD(extack, "High side only for pages other than 0");
> +		return -EINVAL;
> +	}

This is in the core already.


> +
> +	if ((page_data->length + page_data->offset) > 256) {
> +		NL_SET_ERR_MSG_MOD(extack, "Read past the end of the page");
> +		return -EINVAL;
> +	}

Also in the core.

> +
> +	switch (page_data->page) {
> +	case 0:
> +		src = &idev->port_info->status.xcvr.sprom[page_data->offset];
> +		break;
> +	case 1:
> +		src = &idev->port_info->sprom_page1[page_data->offset - 128];
> +		break;
> +	case 2:
> +		src = &idev->port_info->sprom_page2[page_data->offset - 128];
> +		break;
> +	default:
> +		return -EINVAL;

It is a valid page, your firmware just does not support it. EOPNOSUPP.


> +	}
> +
> +	memset(page_data->data, 0, page_data->length);
> +	err = ionic_do_module_copy(page_data->data, src, page_data->length);
> +	if (err)
> +		return err;
> +
> +	return page_data->length;
> +}
> +
>  static int ionic_get_ts_info(struct net_device *netdev,
>  			     struct kernel_ethtool_ts_info *info)
>  {
> @@ -1199,6 +1248,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
>  	.set_tunable		= ionic_set_tunable,
>  	.get_module_info	= ionic_get_module_info,
>  	.get_module_eeprom	= ionic_get_module_eeprom,
> +	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,

If i remember correctly, implementing .get_module_eeprom_by_page make
.get_module_info and .get_module_eeprom pointless, they will never be
used, so you can delete them.

	Andrew

