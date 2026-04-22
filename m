Return-Path: <netdev+bounces-280422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPGoLxPK6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:16:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE9446967
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDB3630BFDA8
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053323D1711;
	Wed, 22 Apr 2026 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ovaNZUKt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54F3C5DA6;
	Wed, 22 Apr 2026 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863351; cv=none; b=CyeBJRC5J3LW2QStjrGJjPl+Rl3Tyrom76Xt64ZvLZOGanpCNp9hShV+PzA2kfskUr2iE1wZPBANH/DAOgoa9KWuUtiGtukjFmkyVzj+AZqdmweNSUyeUUyl4kuSONq+NRBySOAgOHUHGV+PoN1f8svl7/3fpT6iFgzlQ3XUHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863351; c=relaxed/simple;
	bh=7VnNRb4043zuGtgy7IW6JskocOMtrvW/IkgH8UEHZdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5YT5uO59/mX/tAl4XdyeZj9bGYArYAP/q79DQE2dFXMdCi2u4EgMqGrKrV2b9Io5Qmqqu1LbWMoyA9crRFCpecRsDixNOs5I+cK19PUDZLTIegOIx+b0AY/4VAz3PF4CsYMqftb6HDytpGu1phN6BIE/DIscNAhbjzV9X+AEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ovaNZUKt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bervxqYtV5teAH1yqtVMNUI1fAy05Ee5HjNEL65NNZ4=; b=ovaNZUKtMKk/4ORre+5aI48kX+
	T3jtKj4v4sEd0NX0OUWikaEJQKDwwB3Wr7UizdDn4rimBSMqGrp8qpqYIeTemeTwyeooMkOR+Sq3z
	a69Tm8XqRcaVWSR+Fchb9SZocvcSK9I1ywfa3dk8IkA+g8xsedXP72mXZUeYErh5Hgns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFXK8-00H28l-CV; Wed, 22 Apr 2026 15:09:00 +0200
Date: Wed, 22 Apr 2026 15:09:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: michael@fritscher.net
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net 14/18] drivers: net: xircom: xirc2ps: Remove this
 driver
Message-ID: <45d48a34-e40a-43cc-925a-6734149236de@lunn.ch>
References: <73e3a34c-f1dc-403b-b007-18ff85d66ea1@fritscher.net>
 <408d1987-6ecb-4d3b-afed-8e202c8ff21d@lunn.ch>
 <e36510873a1909a1bfd9a05cde99fef0@fritscher.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36510873a1909a1bfd9a05cde99fef0@fritscher.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-280422-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B0EE9446967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> thanks! If someone mentors me I could try... I have experience with C
> programming, esp. in the embedded world, but (almost) no experience with the
> Linux kernel development.
> But regression tests etc. can be conducted by me - on 32 and 64 bit
> machines. The oldest being a P120, the newest the mentioned X61 with its C2D
> CPU.

For a driver like this, regression testing is mostly what we need,
when we see patches for it.

Please take a look at the MAINTAINERs file, and see if you can send us
a patch adding yourself as the Maintainer of this driver.

Some documents to read:

https://docs.kernel.org/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

For patches to MAINTAINERS, please base the patch on net.

    Andrew

