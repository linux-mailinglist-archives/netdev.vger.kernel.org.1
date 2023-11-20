Return-Path: <netdev+bounces-49189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFFA7F111A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981671C21579
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3342A12B8F;
	Mon, 20 Nov 2023 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dN4RdqzZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673085;
	Mon, 20 Nov 2023 03:00:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67A0D1BF20F;
	Mon, 20 Nov 2023 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTyJpnwdyX1NtPmVrrRCwDHFsynrwrKMO4Vr6Y+8t0s=;
	b=dN4RdqzZMypf7RDvSMRqBfaP0JjV/QaoDakjsBZZjhaNodcWTkD225aT7wfYJQz+Kawq3R
	E2OZllUvUlhgrghyEMpEPlb96IPE8IHjHyRSaJdXKsv6OXivUaqnvSB48Z7tI3grRE7ljb
	vL2Deg1gF1naN3WZ/TV0d+VQa9uTu/12RcIS+8+XyHw6V7Ta06aoqsn174yMhCeNHDjiSB
	kk1nSlj95OHd7wVCwUzSCjsFgvdT9ibBq+zfigbCh5v6GMCac08WTE/oUeXEU0Iwvv6E9S
	HMfctqNVdlBxXKuzqpEMGm+Pe4PZgT/ByOyOoZyAwCP0iehTVvnhyvAmcfBPDQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	David Girault <david.girault@qorvo.com>,
	Romuald Despres <romuald.despres@qorvo.com>,
	Frederic Blain <frederic.blain@qorvo.com>,
	Nicolas Schodet <nico@ni.fr.eu.org>,
	Guilhem Imberton <guilhem.imberton@qorvo.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v5 07/11] mac802154: Handle association requests from peers
Date: Mon, 20 Nov 2023 12:00:37 +0100
Message-Id: <20231120110038.3808085-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-8-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'601f160b61b2152ef84a663f856350d5dd9e752a'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-09-27 at 18:12:10 UTC, Miquel Raynal wrote:
> Coordinators may have to handle association requests from peers which
> want to join the PAN. The logic involves:
> - Acknowledging the request (done by hardware)
> - If requested, a random short address that is free on this PAN should
>   be chosen for the device.
> - Sending an association response with the short address allocated for
>   the peer and expecting it to be ack'ed.
> 
> If anything fails during this procedure, the peer is considered not
> associated.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel

