Return-Path: <netdev+bounces-122629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02476961FE2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5AB1C231DD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5291552FA;
	Wed, 28 Aug 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pv6E+lgq"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0914A60F;
	Wed, 28 Aug 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827067; cv=none; b=WPFQizxzTSfZEPpJK84MhnTonnTT+GgAZaVcwdW9uydP+GeZhaVe4NSlCd0A+YzLfJwOVkN0HXPHVg9mcs2kh3p8fxFOucDEd0UxAMkY6dLzNJ8qXCauHTL9Pi/+ECQjtACvRO0H/ibHVLNmhVqIG3XlFW68dPv7qMAe5TdC4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827067; c=relaxed/simple;
	bh=N2OsUed9HDrLbt2qknx4VhFhL7n7V9Aal595Ul3HF+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQpTwBm/48z0mQ65sTGsEkYzbC5XhEu6RX/eUhn6ID8EyfOMSQ+a50h+6MpC7H0wj2ck9/8dB6Wyjls570afcPvLXaY9MvS3jCxRJG9Y+9O4WZiiIc5/4JU6uW65vFGY1ZoWCb5T+OtZz2gtS/iHxBbxbpmVjOqFoWSAAaL3618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pv6E+lgq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F2F440004;
	Wed, 28 Aug 2024 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724827063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER5Bryh1Q2iy9Ru6aWwleeQoRGbk6xZyDBgO/q0Cb5M=;
	b=Pv6E+lgqOQLiXsPPWJXhWXlVaSkB8QpfFDAn88VhUFgp6JkzOIqcxoXcQopiCvoL/UZ95V
	l0lwGRugGVfewL4ZLzLNOJZt94wGWhDqyhZTJqHsMH6oSjk3XOqHwNKttylx45hgqdAd55
	BwcFPiPB+F12oBRKMQqlI+2C6WZAIiMklICxqrVBwTJ7/YV0B1r0E3pwyfWVCrsoUMRM4x
	yXgQPRoa+2BXtEK5mmrIo0oecWnUZ5lNNCwXp45hnvz6lqw4aOsaWdvBZoOCMx8O06NLWW
	uLHS6RJLnGd9UhL+FAa6mJoj8t1+Gsu6YOnRF9y2UkEmn0hBtK+XtGjw5RrlKQ==
Date: Wed, 28 Aug 2024 08:37:41 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v3] net: ethtool: fix unheld rtnl lock
Message-ID: <20240828083741.01547d18@device-28.home>
In-Reply-To: <20240827124653.51cf9789@kernel.org>
References: <20240826130712.91391-1-djahchankoike@gmail.com>
	<20240826173913.7763-1-djahchankoike@gmail.com>
	<20240827092336.16adeee3@fedora-3.home>
	<20240827124653.51cf9789@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Juakub,

On Tue, 27 Aug 2024 12:46:53 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 27 Aug 2024 09:23:36 +0200 Maxime Chevallier wrote:
> > On Mon, 26 Aug 2024 14:38:53 -0300
> > Diogo Jahchan Koike <djahchankoike@gmail.com> wrote:
> >   
> > > ethnl_req_get_phydev should be called with rtnl lock held.
> > > 
> > > Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
> > > Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
> > > Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>    
> > 
> > This looks good to me.
> > 
> > Even though RTNL is released between the .validate() and .set()
> > calls, should the PHY disappear, the .set() callback handles that. 
> > 
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> 
> I know this isn't very well documented, but the point of .set_validate
> is to perform checks before taking rtnl_lock (which may be quite
> heavily contended), and potentially skip .set completely.
> See 99132b6eb792 ("ethtool: netlink: handle SET intro/outro in the
> common code"). Since we take rtnl lock and always return 1, this starts
> to feel a bit cart before the horse.

That explanation makes a lot of sense, I didn't have in mind that this
is what .set_validate is for.

> How about we move the validation into set? (following code for
> illustration only, please modify/test/review carefully and submit
> as v4 if agreed on):

That would work for me, that makes more sense than the current
approach.

> 
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index ff81aa749784..18759d8f85a5 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -217,13 +217,10 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
>  };
>  
>  static int
> -ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
> +ethnl_set_pse_validate(struct phy_device *phydev, struct genl_info *info)
>  {
> -	struct net_device *dev = req_info->dev;
>  	struct nlattr **tb = info->attrs;
> -	struct phy_device *phydev;
>  
> -	phydev = dev->phydev;
>  	if (!phydev) {
>  		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
>  		return -EOPNOTSUPP;
> @@ -249,7 +246,7 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	return 1;
> +	return 0;
>  }
>  
>  static int
> @@ -258,10 +255,14 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
>  	struct net_device *dev = req_info->dev;
>  	struct nlattr **tb = info->attrs;
>  	struct phy_device *phydev;
> -	int ret = 0;
> +	int ret;
>  
>  	phydev = dev->phydev;

With the updated PHY code, the above context would look like this :

		phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
					      info->extack);
		if (IS_ERR_OR_NULL(phydev))
			return -ENODEV;

>  
> +	ret = ethnl_set_pse_validate(phydev, info);
> +	if (ret)
> +		return ret;
> +
>  	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
>  		unsigned int pw_limit;
>  
> @@ -307,7 +308,6 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
>  	.fill_reply		= pse_fill_reply,
>  	.cleanup_data		= pse_cleanup_data,
>  
> -	.set_validate		= ethnl_set_pse_validate,
>  	.set			= ethnl_set_pse,
>  	/* PSE has no notification */
>  };

This is OK for me. Diogo, as you started addressing this, is it OK for
you to send a V4 with Jakub's proposed changes ?

Thanks,

Maxime

