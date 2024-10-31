Return-Path: <netdev+bounces-140772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED719B7FB1
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75392812D9
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA691A4F0C;
	Thu, 31 Oct 2024 16:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from james.theweblords.de (james.theweblords.de [217.11.55.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E919DF49
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.55.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391106; cv=none; b=ql9+I0d320WOB2ra09JjrXZXeoVXd6gVorx8x2rMpAqhNpDh3mUXgf0gFLwNxcknSkNy0EH9wD1SI/fLZBug2Nku9vMRoceQcrGzl7dgVc3n7Dbu0GTqMtBJ+c50V0uf97T8wwa1IYuMlboOuXz3yPrsdUm04ks/yTQpFFjkdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391106; c=relaxed/simple;
	bh=Pb2MpjWA8AeC6RHOsofIRAdpVT9ibYfeswmALsyeHVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOqZhV6eTGTjjsfdAH15qOsqC8W3pUy1Qly/dWdv3+OE8mlXHvy2qsxr2KHD5kEvE6TXG6Yb8UGHH7ajMpg0p1U0w2Y1hmVkvu9MmYuJErf4WyAGaQrz8PyU4MI+CjnIf8/c0XLVHt0hsU7Fwd1nIX9uLYWxxIhgPMa9e58RdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friiks.de; spf=pass smtp.mailfrom=friiks.de; arc=none smtp.client-ip=217.11.55.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friiks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friiks.de
Received: (qmail 17817 invoked from network); 31 Oct 2024 16:11:34 -0000
Received: from localhost (HELO james.theweblords.de) (petronios@theweblords.de@127.0.0.1)
  by localhost with SMTP; 31 Oct 2024 16:11:34 -0000
Received: from localhost ([89.12.32.63])
	by james.theweblords.de with ESMTPSA
	id u1auITasI2eWRQAA4k8YEw
	(envelope-from <pegro@friiks.de>); Thu, 31 Oct 2024 17:11:34 +0100
Date: Thu, 31 Oct 2024 17:11:33 +0100
From: Peter =?ISO-8859-1?Q?Gro=DFe?= <pegro@friiks.de>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-net v2] i40e: Fix handling changed priv flags
Message-ID: <20241031171133.00001507@friiks.de>
In-Reply-To: <2d6b0d54-57d3-4f3b-833c-8490aa63490d@intel.com>
References: <cf6dd743-759e-4db9-8811-fd1520262412@molgen.mpg.de>
	<20241030172224.30548-1-pegro@friiks.de>
	<03b7d4ef-1e1e-4b9e-84b6-1ff4a5b92b29@molgen.mpg.de>
	<2d6b0d54-57d3-4f3b-833c-8490aa63490d@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am Thu, 31 Oct 2024 08:34:36 +0100
schrieb Przemek Kitszel <przemyslaw.kitszel@intel.com>:

> >> Fixes: 70756d0a4727 ("i40e: Use DECLARE_BITMAP for flags and=20
> >> hw_features fields in i40e_pf")
> >> Signed-off-by: Peter Gro=DFe <pegro@friiks.de> =20
>=20
> Both the code change and the Fixes: tag are correct, thank you!
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Great to hear :)

Would this be material for stable?

I hope to avoid building my own kernel and just use a hwe kernel of Ubuntu.


> BTW, we obey netdev rules on IWL ML - next revision only after 24-48h
> and send as standalone series (instead of In-reply-to) - no need to
> repost this time of course

Sorry, I'm new to submitting patches here.

Is there anything else I need to do?

Kind regards
Peter


