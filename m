Return-Path: <netdev+bounces-280494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A/4AKD26Gl3SAIAu9opvQ
	(envelope-from <netdev+bounces-280494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E6448974
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72B6B305AE19
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C4381B1F;
	Wed, 22 Apr 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgjTxvBi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9038E10F
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874847; cv=none; b=RSLDrPB/lsk7QI9CZpTTsjHRtoD6OYKrs8Ses/dwTJLancG3R+a+em9t+M7mTRyb7miLY1MnCkJHTIJRSWMzV+IY+NIdSKhd1cFPPfW1gVIZE0hxPfQrUuUA/MK40kX8VyFLi+4cATkdYMfuqdCbfooPWVT5r939xlrtdzPEF4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874847; c=relaxed/simple;
	bh=552f9hdt0Q9xyd/Cb6oPTHWO+NEzOX+2d/uM6MbS2OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWsXeGPBmLaoDrZQHwG/8C34DQR5IC3/F2uIqywgD/rCamdYdZnvzJ7auFYio3OgHi9JiPGiHGZMj/kwmG4tq0o+0J/C7CiNRkp9RbxKDDTYqXPHYuyRzNK8RRYSgXe5Fig5FrasJwkRL77GX3wBQhGSFt9LQFaO6YGp9qQAha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgjTxvBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBBBC19425;
	Wed, 22 Apr 2026 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874847;
	bh=552f9hdt0Q9xyd/Cb6oPTHWO+NEzOX+2d/uM6MbS2OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgjTxvBi83hfTofpSFlo88+EJuEGRVFDeCZ/l18hrUWBXQzTJx1U4781OKv4OGGDC
	 pwV6W9Z3sMF93ezLbQFQ9/9pRGe3DefnQLvASUtPOZ/5qYczxj4gkif4DzEzKlB7w0
	 fHCQuGl+2kcwbax+S7ICOP7xmo6q7P4zxL9g3d9e4t9qvE3nIEs6bmz/U7qfYbOGfA
	 im/HSL0eFRevOvaVgE12KPYM8SC+wuP6B/Myn5MvMl1tAYxpygLDyIABNFKyoTPdsg
	 OMPO2BcInv8IIxBX1qbTguitq2wTEX86fZAksrLVPgkSDpt98V31n5xeTdOXxrjc5P
	 WTZCzF/rpZ1yw==
Date: Wed, 22 Apr 2026 17:20:41 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	kees@kernel.org, yuantan098@gmail.com, ylong030@ucr.edu,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn
Subject: Re: [PATCH net v2 2/2] 8021q: delete cleared egress QoS mappings
Message-ID: <20260422162041.GO651125@horms.kernel.org>
References: <9136768189f8c6d3f824f476c62d2fa1111688e8.1776647968.git.yuantan098@gmail.com>
 <ecfa6f6ce2467a42647ff4c5221238ae85b79a59.1776647968.git.yuantan098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecfa6f6ce2467a42647ff4c5221238ae85b79a59.1776647968.git.yuantan098@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,ucr.edu,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid,lzu.edu.cn:email,ucr.edu:email]
X-Rspamd-Queue-Id: F33E6448974
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:18:46AM +0800, Ren Wei wrote:
> From: Longxuan Yu <ylong030@ucr.edu>
> 
> vlan_dev_set_egress_priority() currently keeps cleared egress
> priority mappings in the hash as tombstones. Repeated set/clear cycles
> with distinct skb priorities therefore accumulate mapping nodes until
> device teardown and leak memory.
> 
> Delete mappings when vlan_prio is cleared instead of keeping tombstones.
> Now that the egress mapping lists are RCU protected, the node can be
> unlinked safely and freed after a grace period.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/8021q/vlan_dev.c     | 20 ++++++++++++++------
>  net/8021q/vlan_netlink.c |  4 ----
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index a5340932b657..7aa3af8b10ea 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -172,26 +172,34 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
>  				 u32 skb_prio, u16 vlan_prio)
>  {
>  	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> +	struct vlan_priority_tci_mapping __rcu **mpp;
>  	struct vlan_priority_tci_mapping *mp;
>  	struct vlan_priority_tci_mapping *np;
>  	u32 bucket = skb_prio & 0xF;
>  	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
>  
>  	/* See if a priority mapping exists.. */
> -	mp = rtnl_dereference(vlan->egress_priority_map[bucket]);
> +	mpp = &vlan->egress_priority_map[bucket];
> +	mp = rtnl_dereference(*mpp);
>  	while (mp) {
>  		if (mp->priority == skb_prio) {
> -			if (mp->vlan_qos && !vlan_qos)
> +			if (!vlan_qos) {
> +				rcu_assign_pointer(*mpp, rtnl_dereference(mp->next));
>  				vlan->nr_egress_mappings--;
> -			else if (!mp->vlan_qos && vlan_qos)
> -				vlan->nr_egress_mappings++;
> -			WRITE_ONCE(mp->vlan_qos, vlan_qos);
> +				kfree_rcu(mp, rcu);
> +			} else {
> +				WRITE_ONCE(mp->vlan_qos, vlan_qos);
> +			}
>  			return 0;
>  		}
> -		mp = rtnl_dereference(mp->next);
> +		mpp = &mp->next;
> +		mp = rtnl_dereference(*mpp);
>  	}

Hi Ren,

Thanks for splitting up the patchset, it is very helpful to me.

It seems to me that the mpp/mp construct used is a bit complex and
stems from the use of a hand-rolled list centred the next field of
struct vlan_priority_tci_mapping.

I wonder if things can be simplified by moving to use a standardised
list construct, such as an hlist. And the helpers available for using it.

>  
>  	/* Create a new mapping then. */
> +	if (!vlan_qos)
> +		return 0;
> +
>  	np = kmalloc_obj(struct vlan_priority_tci_mapping);
>  	if (!np)
>  		return -ENOBUFS;

...

