Return-Path: <netdev+bounces-279393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLBQIF1y4mnR5wAAu9opvQ
	(envelope-from <netdev+bounces-279393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:48:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0960941DACD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 015BB300B9A2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB85234EF17;
	Fri, 17 Apr 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="G8ioTg1P"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDF2FFDC4;
	Fri, 17 Apr 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448018; cv=none; b=BKwZQneNI4xoh4J/hkW6Z8p6zpW+uTgQqzPdMxfIuFtaIIULff9iGExxiIC96LXjk/LxNcYicOuZ5OE6dldlJ3unjx+6SColCWX43deqhvt1XBR2bSZzKhbA71h7LJyJElsqSzmDdWeKe7aTOQSpTCPRUi+d179uP7EOZL+Fn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448018; c=relaxed/simple;
	bh=LqpISmas26GAA+eigkPeHlqbzpTvgtAgzvLgkNHtNUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Maq49Xp7xfzGlXi+ftk3YIsxlzwYAs0X5HcTgVFe4OZ2HeDmuVyFNrndmHWs99AtLf0HmzEd+Ui6crGejOGuxw5NdvWrZ3c+e1C2X5a+SwrOxw3B0GwbXFebi40H9jmmU6lN3y7qT+q7sDldxJ064cFGVGp2LlfPqP90KVvakyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=G8ioTg1P; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k8m/KTTmnq5PY9ru1DsdH08IpJYZRyWyKs1/HT27WEs=; b=G8ioTg1PqKwL/Klcpomt6dE9Xa
	JPpL9IJjXkGPag8r3o9xajKGIy4+9OeXkj2D8YjNECvgQYyIqbGBNLkfK8n0v2zLaNpkkzbUeWsIO
	UdQ7d8v4rw1Tr9oyOhpJcCg2Is/sNrdSW4x9Tl3TeSuoaCOxBHZbd+3k5tlxVQdswdWacHoXN71uh
	uO3smsPJZN8s46HtaAOfNz6/wHDxoox2OaYKSBtgqw3khAoHH6vZ2xn7YAMFylVphR5FxO6N7ya/A
	EgTsq2S/5sPLv3+4mXLX6Jn1Tg0EvE9JbVMvk5LXYzKaqRYWvmB2KYPhd1F1GQxm7Fpa772McW2xo
	klQbWTaQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wDnH2-00FY4p-1L;
	Fri, 17 Apr 2026 17:46:36 +0000
Date: Fri, 17 Apr 2026 10:46:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, 
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Frank Wunderlich <frank-w@public-files.de>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <aeJjcoHyezEgUG_Q@gmail.com>
References: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279393-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,public-files.de,phrozen.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0960941DACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 04:55:57AM +0100, Daniel Golle wrote:
> @@ -3404,6 +3449,9 @@ EXPORT_SYMBOL_GPL(mt7530_probe_common);
>  void
>  mt7530_remove_common(struct mt7530_priv *priv)
>  {
> +	if (priv->bus)
> +		cancel_delayed_work_sync(&priv->stats_work);
> +

Shouldn't you cancel the work later, after dsa_unregister_switch()?

I am wondering if the following race cannot happen:

 mt7530_remove_common()                  someone reading /proc/net/dev
    cancel_delayed_work_sync()
      /* returns: work neither pending
         nor executing - true at this
         instant */
                                          mt7530_get_stats64()
                                            mod_delayed_work(...)
                                            /* work is queued again */
    dsa_unregister_switch()
    return

