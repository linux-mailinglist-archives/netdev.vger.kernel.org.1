Return-Path: <netdev+bounces-200071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA5EAE2FB7
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 14:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D69F16E4B8
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9251A5B99;
	Sun, 22 Jun 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CQ1tA+aQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65A6FC3
	for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750593633; cv=none; b=hap5vSgd9Ygx/x9XJshDApcAL6NzuNhqZJmQCQC/SyObF4B2p9Nr6zs+1L7hONtGJ2IY7GLDAI0OQt6ysMRxUfPqznzKFW7SJW0BMwuLh92/3huMJQqtp5ASU/j9E1xAqsmhTz16DRMBe7G5n+s53v/He3DNOKYMFpPE2l8fSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750593633; c=relaxed/simple;
	bh=zBNvRskf817EavQQMkeYPqNP7m30Ui3ktH/2YMK0sdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aG5r7j245dEFjFujfLpN+80wqKmKh06r5bkPfR0B0Xir5N0pQjEbHX9JcXEomDLfniJzkF3naltZ/g3ELqWEjOObMYz2a0dTPdObIDE09zu/7xBjpfLk5otlbAZ8mEFNKeuAovBGar4v5W5JZMUbGETLZ4HdO5L904cNuaVZhp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CQ1tA+aQ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6044241DF1;
	Sun, 22 Jun 2025 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750593623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hehsCdxtE1jP6qs0NGtONFdMEx2bD3nzoBCvjp/+s3c=;
	b=CQ1tA+aQlHwEEXwHuPe4zgFHHooK6vNDYxf9+ixfwpsz3oWajC0cewlBygC2hRvws7ouXd
	lRAzj5s4fhdGuXkBkxngxQ/js/IJ9VPi37OWQgkhSlcxvSRYcXhcnJIeaCtc634LnetSD4
	ifJfg35ffQkfSg9KpPGpho63vu2kbnwnrOUDe20m6dLa+YGgoOjvTKQKZ3WBM+7IjnDIAk
	ddaTkEChbYFa8rC3G4g7slP5G+eGRNAxqiKb5F2WwA/u3BG83CuEwYZrobhvOHQFW0PgNB
	8cb/YWU28D6G7Ie5JfVYK0O9U8czij7pdSf7ZyTfl4YCWgR0foZnTSrIc986dQ==
Date: Sun, 22 Jun 2025 14:00:20 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 5/9] net: ethtool: copy req_info from SET to
 NTF
Message-ID: <20250622140020.3dcc6814@fedora.home>
In-Reply-To: <20250621171944.2619249-6-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
	<20250621171944.2619249-6-kuba@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugedutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppeeltddrjeeirdeivddrudejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrjeeirdeivddrudejuddphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhun
 hhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Sat, 21 Jun 2025 10:19:40 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Copy information parsed for SET with .req_parse to NTF handling
> and therefore the GET-equivalent that it ends up executing.
> This way if the SET was on a sub-object (like RSS context)
> the notification will also be appropriately scoped.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for that !

> ---
>  net/ethtool/netlink.h |  5 ++++-
>  net/ethtool/netlink.c | 14 +++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index 4a061944a3aa..373a8d5e86ae 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -23,7 +23,8 @@ void *ethnl_dump_put(struct sk_buff *skb, struct netlink_callback *cb, u8 cmd);
>  void *ethnl_bcastmsg_put(struct sk_buff *skb, u8 cmd);
>  void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd);
>  int ethnl_multicast(struct sk_buff *skb, struct net_device *dev);
> -void ethnl_notify(struct net_device *dev, unsigned int cmd, const void *data);
> +void ethnl_notify(struct net_device *dev, unsigned int cmd,
> +		  const struct ethnl_req_info *req_info);
>  
>  /**
>   * ethnl_strz_size() - calculate attribute length for fixed size string
> @@ -338,6 +339,8 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
>   *	header is already filled on entry, the rest up to @repdata_offset
>   *	is zero initialized. This callback should only modify type specific
>   *	request info by parsed attributes from request message.
> + *	Called for both GET and SET. Information parsed for SET will
> + *	be conveyed to the req_info used during NTF generation.
>   * @prepare_data:
>   *	Retrieve and prepare data needed to compose a reply message. Calls to
>   *	ethtool_ops handlers are limited to this callback. Common reply data
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 129f9d56ac65..f4a61016b364 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -911,7 +911,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
>  	swap(dev->cfg, dev->cfg_pending);
>  	if (!ret)
>  		goto out_ops;
> -	ethtool_notify(dev, ops->set_ntf_cmd);
> +	ethnl_notify(dev, ops->set_ntf_cmd, req_info);
>  
>  	ret = 0;
>  out_ops:
> @@ -950,7 +950,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
>  
>  /* default notification handler */
>  static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
> -				 const void *data)
> +				 const struct ethnl_req_info *orig_req_info)
>  {
>  	struct ethnl_reply_data *reply_data;
>  	const struct ethnl_request_ops *ops;
> @@ -979,6 +979,9 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
>  
>  	req_info->dev = dev;
>  	req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
> +	if (orig_req_info)
> +		memcpy(&req_info[1], &orig_req_info[1],
> +		       ops->req_info_size - sizeof(*req_info));

Is there any chance we can also carry orig_req_info->phy_index into
req_info ? That's a bit of sub-command context that is also useful for
notifications, especially PLCA. As of today, the PLCA notif after a SET
isn't generated at all as the phy_index isn't passed to the ethnl
notification code.

Maxime

