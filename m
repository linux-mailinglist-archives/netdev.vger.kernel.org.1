Return-Path: <netdev+bounces-124470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3595969943
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719D7286439
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0E71A0BE9;
	Tue,  3 Sep 2024 09:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF411A0BC8
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356300; cv=none; b=T0fumQst8PooXd1VuTQxoacAR8ZO72PlvLkWYt8IV6rCdQRQINC7EjDzcJPpdRPVe1erKbHtzuwPmMwq0k6Nmoe8zc/RGfJ/8/jNpYMS9HN9Hm3KPBD4Y8INZ8c/GOzFjS6xA2H+DqCBiURM5BT5+XmbfKJEMaV7BcDMKA/7/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356300; c=relaxed/simple;
	bh=5J6KdP2Oj9RJK48xtumgyC8tF7u+LNmkzQUFdbvZH08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9SobMvwCqQCsuhwB6ZhW4qVujd+FmyZodzo2csj1HVQPi9hOqPzr5cYCOD73fOancG9nFW/A5c69ryEs25lF4HdqURDBfo5UCBxJ4an3XcXJLDPSJwFEJuqh0UiooJGp4Up/sXsWXipzTyDAd7MvEor6hOup/di4ZjYZMQ0kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-kutVcPASMXiW5EbXuE9tXA-1; Tue,
 03 Sep 2024 05:38:06 -0400
X-MC-Unique: kutVcPASMXiW5EbXuE9tXA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D7331956064;
	Tue,  3 Sep 2024 09:38:04 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73B8030001A4;
	Tue,  3 Sep 2024 09:37:58 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:37:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, richardcochran@gmail.com,
	bharatb.linux@gmail.com
Subject: Re: [net-next PATCH v8 5/8] cn10k-ipsec: Add SA add/del support for
 outb ipsec crypto offload
Message-ID: <ZtbY9AF1fjUCcBOH@hog>
References: <20240903045937.1759543-1-bbhushan2@marvell.com>
 <20240903045937.1759543-6-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903045937.1759543-6-bbhushan2@marvell.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

2024-09-03, 10:29:34 +0530, Bharat Bhushan wrote:
> +static int cn10k_ipsec_validate_state(struct xfrm_state *x)
> +{
> +	struct net_device *netdev = x->xso.dev;
> +
> +	if (x->props.aalgo != SADB_AALG_NONE) {
> +		netdev_err(netdev, "Cannot offload authenticated xfrm states\n");

This should use extack, to return this information directly to the
application that's creating the invalid config. You can propagate it
from cn10k_ipsec_add_state down to this function, and then:

    NL_SET_ERR_MSG_MOD(extack, "Cannot offload authenticated xfrm states");


> +static int cn10k_ipsec_inb_add_state(struct xfrm_state *x)
> +{
> +	struct net_device *netdev = x->xso.dev;
> +
> +	netdev_err(netdev, "xfrm inbound offload not supported\n");

Here too, extack.

> +	return -EOPNOTSUPP;
> +}
> +
> +static int cn10k_ipsec_outb_add_state(struct xfrm_state *x)
> +{
> +	struct net_device *netdev = x->xso.dev;
> +	struct cn10k_tx_sa_s *sa_entry;
> +	struct cpt_ctx_info_s *sa_info;
> +	struct otx2_nic *pf;
> +	int err;
> +
> +	err = cn10k_ipsec_validate_state(x);
> +	if (err)
> +		return err;
> +
> +	pf = netdev_priv(netdev);
> +	if (!mutex_trylock(&pf->ipsec.lock)) {

Why not wait until we can take the lock? Failing to offload the state
because this lock is temporarily busy isn't nice to users.

> +		netdev_err(netdev, "IPSEC device is busy\n");
> +		return -EBUSY;
> +	}
> +
> +	if (!(pf->flags & OTX2_FLAG_IPSEC_OFFLOAD_ENABLED)) {
> +		netdev_err(netdev, "IPSEC not enabled/supported on device\n");

You should also use extack in this function.


[...]
> +static void cn10k_ipsec_del_state(struct xfrm_state *x)
> +{
> +	struct net_device *netdev = x->xso.dev;
> +	struct cn10k_tx_sa_s *sa_entry;
> +	struct cpt_ctx_info_s *sa_info;
> +	struct otx2_nic *pf;
> +	int sa_index;
> +
> +	if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
> +		return;
> +
> +	pf = netdev_priv(netdev);
> +	if (!mutex_trylock(&pf->ipsec.lock)) {
> +		netdev_err(netdev, "IPSEC device is busy\n");
> +		return;

If we can't take the lock, we leave the state installed on the device
and leak some memory? That's not good. I assume we're going to reach
HW limits if this happens a bunch of times, and then we can't offload
ipsec at all anymore?

I think it would be better to wait until we can take the lock.

-- 
Sabrina


