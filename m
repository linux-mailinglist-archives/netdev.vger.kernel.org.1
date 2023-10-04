Return-Path: <netdev+bounces-38032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D87B8AC0
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 0B5411C20442
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B15D1CA9D;
	Wed,  4 Oct 2023 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="onM9nSA/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B71D68D;
	Wed,  4 Oct 2023 18:38:51 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9481AEA;
	Wed,  4 Oct 2023 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c9omko4YDrGmNR4EWL/kMfaK1/W1hCSP1tNyvEP0h/w=;
	t=1696444729; x=1697654329; b=onM9nSA/koMMqzv9mQSmAJzc+787x5mdQD7Gp7uRF2yPtns
	hU15C/aSIag0FhE0PcYif5heDbWJjoOoGc9ffY1ccSAGPRdQYfj00qaVZ4FstVnagkSUasSGnq3iN
	mrhzzT4wGNR9ja3x9yotcIJN4CpcttKwnshIMcxSaI5Nmz66zcIJ2DExjaV4usmZe2P6OcpbXJ0Xb
	gu5GON/GUF3iVd29ad9GeiJy74TvvOZ8u3YJHq5yhgBHOlhSWS8sU8PjHJCQFj0dcTkeo9mA3xUZy
	uI5B2aPn7yVs6F8LwUud4TOMXj6gOpNPqldLT0R4zIzWv3yb73WAVEHWQyffjA1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC0)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qo6lj-00000004Pw2-1zuU;
	Wed, 04 Oct 2023 20:38:47 +0200
Message-ID: <46b5785866870e9c1aefbe222d69fbacb93c1cdd.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Wed, 04 Oct 2023 20:38:46 +0200
In-Reply-To: <20231004092205.02c8eb0b@kernel.org>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
	 <20231004092205.02c8eb0b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-04 at 09:22 -0700, Jakub Kicinski wrote:
>=20
> Potentially naive question - the trace point holds enum skb_drop_reason.
> The user space can get the names from BTF. Can we not teach user space
> to generically look up names of enums in BTF?

I'll note that, unrelated to the discussion about whether or not we
could use BTF, we couldn't do it in this case anyway since the whole
drop reasons aren't captured in enum skb_drop_reason, that contains only
the core ones, and now other subsystems are adding their own somewhat
dynamically later.

johannes


