Return-Path: <netdev+bounces-229761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C305BE0955
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 390124E0EB8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69230B530;
	Wed, 15 Oct 2025 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhaxCj6r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA52FF666;
	Wed, 15 Oct 2025 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559021; cv=none; b=d/UbCUzguuEZLAWpyk1Cyd0w47mOXyYO+5+lF+ndV46wwlX23OEroAVFusUuxVUtlDE/+puLonAZ9oyyuodqQ02VyTCAmSzjIdwMbR1OfrQAFTPBwohDnBRSXU21DQhXmKyVmU4qR2igRQS+ccAQhKsiFagCo6mZ3KYcVxMU2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559021; c=relaxed/simple;
	bh=SOZY9Lc2LGZhqkM7yzg6TGePUWoTyfNPHq8nNzy4Q9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCzizq0EejYZ6nsgh2oD1mYJEqURoUE5kzgnHi0HA0iRBx79XsubYzvXNmhPq3nW6LosQmeRcXmXM90tsVtInpPKrMuHgyhjOXqJvYSpgfnFHw1pkt4TCtPhP98XcanIqukqeOsbSS75sf9t0GnAzjfY4hteX1ymmbcKAwixFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhaxCj6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95B3C4CEF8;
	Wed, 15 Oct 2025 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760559020;
	bh=SOZY9Lc2LGZhqkM7yzg6TGePUWoTyfNPHq8nNzy4Q9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MhaxCj6r8ju+SAo/8hVpwAMJ6AMilNaRNZwyi2tSGLW7iDzp19aDDjmRhXMhsrA0m
	 4CK7wmAe7orp4bSiL8SLbmhUd6KhOSWZGcSiSGz8S+nnt4RC54nPIr7wCfFVnj2Zpn
	 pRm89HnspSTB8/HlkbsbdCtoGtQ+Q2rSKINDqIqVPvorFf0VXrmYQ48VfdT18EXlA/
	 2I54ernbIkkkSiEXdw5odkN5YwyVIHy2J01jG7e5rZJosjtOh629Zod6TrtLANpcwD
	 BcGdz6xs1FgSSmt4Zgupn35pVyVGcRtquDrnqJzWGj5LpR9DPaxMhGevXD4K0nzwpS
	 XNqG7MZ3OV4pg==
Date: Wed, 15 Oct 2025 13:10:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
 <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
 <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v01 5/9] hinic3: Add netdev register interfaces
Message-ID: <20251015131018.102569da@kernel.org>
In-Reply-To: <85a6aab1f40d6078279c07e28e08b879bdee207c.1760502478.git.zhuyikai1@h-partners.com>
References: <cover.1760502478.git.zhuyikai1@h-partners.com>
	<85a6aab1f40d6078279c07e28e08b879bdee207c.1760502478.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 15:15:31 +0800 Fan Gong wrote:
> +static int hinic3_netdev_event(struct notifier_block *notifier,
> +			       unsigned long event, void *ptr);

please reorder the code to avoid the fwd declaration

> +/* used for netdev notifier register/unregister */
> +static DEFINE_MUTEX(hinic3_netdev_notifiers_mutex);
> +static int hinic3_netdev_notifiers_ref_cnt;
> +static struct notifier_block hinic3_netdev_notifier = {
> +	.notifier_call = hinic3_netdev_event,
> +};
> +
> +static u16 hinic3_get_vlan_depth(struct net_device *netdev)
> +{
> +	u16 vlan_depth = 0;
> +
> +#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
> +	while (is_vlan_dev(netdev)) {
> +		netdev = vlan_dev_priv(netdev)->real_dev;
> +		vlan_depth++;
> +	}
> +#endif
> +	return vlan_depth;
> +}
> +
> +static int hinic3_netdev_event(struct notifier_block *notifier,
> +			       unsigned long event, void *ptr)
> +{
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	u16 vlan_depth;
> +
> +	if (!is_vlan_dev(ndev))
> +		return NOTIFY_DONE;
> +
> +	dev_hold(ndev);

please use netdev_hold()

> +	switch (event) {
> +	case NETDEV_REGISTER:
> +		vlan_depth = hinic3_get_vlan_depth(ndev);
> +		if (vlan_depth == HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT) {
> +			ndev->vlan_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
> +		} else if (vlan_depth > HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT) {
> +			ndev->hw_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
> +			ndev->features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
> +		}
> +
> +		break;
> +
> +	default:
> +		break;
> +	};

unnecessary semicolon

> +	dev_put(ndev);
-- 
pw-bot: cr

