Return-Path: <netdev+bounces-250510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C79D305A1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38628301F00F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCD0376BF8;
	Fri, 16 Jan 2026 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IugCm/d5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BA36E497
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562787; cv=none; b=SAoewdodkqiooB//iaSSsxqn3sIVKGeW2zefps9hSLuY2ucAbDkOwnZMesZ1ssqiquVPFzigMGJpYgPhs5NXnaXMLJAx4fCyyCiT3iSuv0kbAtwkhTetP8pB7UJHh2dJ35VkjWXhYxrwzRTS/c8IPdx45WeeiOwFIojpA41hAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562787; c=relaxed/simple;
	bh=WNc+2MsWdZaGi3go+XrMPLRzFieqGh5CWiqiyTLLBRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPVA3Hgm6GUzVtucRRFYoGK1tbu+EOyHHJ/75s1WnZ8xG9AJhOmh+zWoGTtBoOSGlW9FSOibtVNUOpKK2B7wvJ4vaBqGq0CaWdNHQQPOTpoKYP1kbpnsZmTLb+r7RoYHqJcOMWigAGVToIPJC93Z0OgUJCO1SHX3tCJHnAqpzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IugCm/d5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E19C116C6;
	Fri, 16 Jan 2026 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768562787;
	bh=WNc+2MsWdZaGi3go+XrMPLRzFieqGh5CWiqiyTLLBRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IugCm/d58Gu/M/EQAZoGMrSWpW7xe23f2te8xheaq7rfgGCwezs78WvSVFtpqC1HG
	 rUfeErdlpfWxMw7+ufp9buXtRDUrxU1NkXJwWrkqoREu1BDaYLOPAel2wgjlXjPNgT
	 fF98LiKHvtnPtujth7llqTUhiVVTgd8L0wdBjvk9nImUGKNqfMUrgDak2mAsbCCKsu
	 lzBXb1xC/jmb7w0pqi0j+956Ouyfbfn7oYrVRfylSVa9F5K97/ZyR71a/v2WlVqBgC
	 ukGz/kSw9EoFUjTSuCl7tSFIe10c1FSmYJTMEYAhWmocN4hYfZP1t7GAJMz2KH1WOv
	 kjYZMc3wqUVoA==
Date: Fri, 16 Jan 2026 11:26:22 +0000
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next 4/6] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aWogXn5hUay3iTd_@horms.kernel.org>
References: <cover.1767964254.git.antony@moon.secunet.de>
 <3558d8c20a0a973fd873ca6f50aef47a9caffcdc.1767964254.git.antony@moon.secunet.de>
 <aWZdTOXTn_YBKKhv@horms.kernel.org>
 <aWe_sIibKYzdWL9C@Antony2201.local>
 <aWjvUllZ7Clf3pm5@horms.kernel.org>
 <aWoatI4v84lJAC48@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWoatI4v84lJAC48@Antony2201.local>

On Fri, Jan 16, 2026 at 12:02:12PM +0100, Antony Antony wrote:
> On Thu, Jan 15, 2026 at 01:44:50PM +0000, Simon Horman via Devel wrote:
> > On Wed, Jan 14, 2026 at 05:09:20PM +0100, Antony Antony wrote:
> > 
> > Hi Antony,
> > 
> > > Hi Simon,
> > > 
> > > On Tue, Jan 13, 2026 at 02:57:16PM +0000, Simon Horman via Devel wrote:
> > > > On Fri, Jan 09, 2026 at 02:38:05PM +0100, Antony Antony wrote:
> > 
> > ...
> > 
> > > > > +static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
> > > > > +				   const struct xfrm_encap_tmpl *encap,
> > > > > +				   const struct xfrm_user_offload *xuo)
> > > > > +{
> > > > > +	int err;
> > > > > +	struct sk_buff *skb;
> > > > > +	struct net *net = &init_net;
> > > > > +
> > > > > +	skb = nlmsg_new(xfrm_migrate_state_msgsize(!!encap, !!xuo), GFP_ATOMIC);
> > > > > +	if (!skb)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	err = build_migrate_state(skb, um, encap, xuo);
> > > > > +	if (err < 0) {
> > > > > +		WARN_ON(1);
> 
> kfree_skb(skb); replace the above line; explained bellow
> 
> > > > > +		return err;
> > > > 
> > > > skb seems to be leaked here.
> > > > 
> > > > Also flagged by Review Prompts.
> > > 
> > > I don't see a skb leak. It also looks similar to the functions above.
> > 
> > xfrm_get_ae() is the previous caller of nlmsg_new() in this file.
> > It calls BUG_ON() on error, so leaking is not an issue there.
> > 
> > The caller before that is xfrm_get_default() which calls kfree_skb() in
> > it's error path. Maybe I'm missing something obvious, but I was thinking
> > that approach is appropriate here too.
> 
> You’re right. There is a leak in the error path.
> 
> The new helper I added is similar to build_migrate(), but that code uses
> BUG_ON() on the error path. That feels too extreme here (even though there
> are other instances of it in the same file).

FWIIW, the use of BUG_ON in xfrm_get_ae() did give me pause for thought.

> 
> I’ll follow the pattern in xfrm_get_default(): handle the error by freeing
> the skb (kfree_skb()) and returning an error. And no WARN_ON().
> 
> I’ll send v3 shortly.

Thanks!

