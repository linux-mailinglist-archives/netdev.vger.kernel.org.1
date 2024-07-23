Return-Path: <netdev+bounces-112551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4CB939E4C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D77B283365
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7809822EE8;
	Tue, 23 Jul 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bS9ARWWm"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD638F9C
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728523; cv=none; b=gtpNfzH5H1/2eooLCnvirwvay5E28/sAco10IRiqBHftbWZo209Jb3dueQRUMmA6CW9RJkXN02+cBCO7okXEr7bQHn2L+oYyiTVvl8YMQhb+PbEc0WD57GBT7MR2I12QTdsgxB17pHHkWybgthESN0PcBMAFbQVGzT4UjvsK+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728523; c=relaxed/simple;
	bh=HD56dOwtGcYJd/aC6Md6e9vGOE/Usykltkeii4r9t8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paYOcZQ180RhzYoSlb2jTYW4bxXXYJHfvCLcvNFckrgKZya+flcfo7pAiTJ7OXP+FN4NQ/BdJ87+tV3mm/9hMS1VoDV+iAfifU/CxJev4ee/jQTRHWceIx5V6Cc0UoyFV4QtJN0ji88AjRckwpwaIr+29bCsseqp3G4E+h2w++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bS9ARWWm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HD56dOwtGcYJd/aC6Md6e9vGOE/Usykltkeii4r9t8A=;
	t=1721728519; x=1722938119; b=bS9ARWWmSGjMnu/tdD4hoMTBcbcmVDclT15NOfYsEFcgwTg
	19na2yNMf/gUbhWW9TI8sADhwf3sZ/9RVs28SpDhHnci0szqrQJgj+jnZu6wSzph7jhInyNN9HXJe
	MZtq2NOk/Gj98xLHSFcNhDOdvOeRfcmtZY/ZC9CPf80ONBFqCUJ/HOdB1bL51YFVh6W+t3xhYdew8
	vmFLLlb7OjbGPcMMNMrZD4/vcE6yLGtu54IKEHSzwimCVD7SRSdHsToxn4o0OwM/klaXW/1mcZCY+
	o+oUEsCOugW/mJrNhoVOpHwpsY6h22CW8c6shd3ofvYl1j8bjAFiEUG/vZ0P2yPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWCEm-0000000B60U-1F0m;
	Tue, 23 Jul 2024 11:55:16 +0200
Message-ID: <a2a58f9c0a27c492efdf6bd82a81ec9f604cd1f0.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: drop special comment style
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Alexandra Winter <wintera@linux.ibm.com>, Stephen Hemminger
	 <stephen@networkplumber.org>
Date: Tue, 23 Jul 2024 11:55:15 +0200
In-Reply-To: <ebe772a2-9350-45c3-8c73-cda0cc5c804b@redhat.com>
References: 
	<20240718110739.503e986bf647.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
	 <ebe772a2-9350-45c3-8c73-cda0cc5c804b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-07-23 at 11:51 +0200, Paolo Abeni wrote:
>=20
> On 7/18/24 20:07, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > As we discussed in the room at netdevconf earlier this week,
> > drop the requirement for special comment style for netdev.
>=20
> I hope Jakub or Eric were present in that room?

Jakub, Eric, Andrew, and a whole lot of other people :)

johannes

