Return-Path: <netdev+bounces-241927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5566C8A987
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 895154E4565
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D532FA31;
	Wed, 26 Nov 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6AHapSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AC32F753
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170373; cv=none; b=FBKTaDIBvw6B3oHnvzfhzmlxM6ph59TB0OyhMsjXAdJ6kNzV/WwFATKZhd6cnIJ9RTplj7Gl9qy0PlUm8Ndm+G9X2Yo5uQ0qzzY9zdCbkOOwkyX/+z0BW5o3MkHuDsF+/OLo0XRCUl6SsQfXXCkjfxhAoVzumn0/cOdsflkjViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170373; c=relaxed/simple;
	bh=sC4ccuy52ILzRu/WxDeQTgwpUQhgqSgtz7VwGnZfrqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ds7hTcC7h5b0KPl5Jz1PjuXnd4i0ORnMSfTMyKTM+xVHuE9IjEzXXH0imZtrOaYREkf70fSJAIEpzw64KiTnMtQ3cStibnlvGXSPDNruwlViIeMLCAtFDPxVERRuq/V1Nao21MaMr0Gm9Ffhmx0T9/eOx3ComqNYKAAphFhYfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6AHapSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29200C4CEF7;
	Wed, 26 Nov 2025 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764170371;
	bh=sC4ccuy52ILzRu/WxDeQTgwpUQhgqSgtz7VwGnZfrqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K6AHapSZ1Zdh7j9BJp9wxHiQL2m6f9lDXL5iJLABHN/3eAWf5puQnOyUwIgBPCvOF
	 4SLVWqR9p15jZwiQKyVItVc/iCObJq6kyhZM/um0vW/+QdNUdQojUnbV2oKkSJKJcz
	 dhsHec4bfPq/IsoNj/f5vbRdXrSn3SvO+i6m/9NKXyVcvQ1GWNHTgmGemxpfThxucm
	 Pr/P+tCjfWI4HsFs4r7+QUpgrTvFhvPX7EIvmmGemLDc+lJQ816MXlVjcGDE0GoRDW
	 1JmZpJyik7gdRpEDVxsl6uFonJu+4GcQJ2RSUlkiJOrQskoEawlFBcCKle6LRfs3Bb
	 FlvSlE7E7HBNA==
Date: Wed, 26 Nov 2025 07:19:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <20251126071930.76b42c57@kernel.org>
In-Reply-To: <20251118071302.5643244a@kernel.org>
References: <20251114082014.750edfad@kernel.org>
	<aRrbvkW1_TnCNH-y@fedora>
	<aRwMJWzy6f1OEUdy@fedora>
	<20251118071302.5643244a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 07:13:02 -0800 Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 06:03:17 +0000 Hangbin Liu wrote:
> > > Hmm, this one is suspicious. I can reproduce the ping fail on local.
> > > But no "otherhost" issue. I will check the failure recently.    
> > 
> > This looks like a time-sensitive issue, with
> > 
> > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> > index c4711272fe45..947c85ec2cbb 100755
> > --- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> > +++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> > @@ -30,6 +30,7 @@ check_connection()
> >         local message=${3}
> >         RET=0
> > 
> > +       sleep 1
> >         ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
> >         check_err $? "ping failed"
> >         log_test "${bond_mode}/${xvlan_type}_${xvlan_mode}: ${message}"
> > 
> > I run the test 100 times (vng with 4 cpus) and not able to reproduce it anymore.
> > That maybe why debug kernel works good.  
> 
> I see. I queued up a local change to add a 0.25 sec wait. Let's wait 
> a couple of days and see how much sleep we need here, this function 
> is called 96 times if I'm counting right.

Hi Hangbin!

The 0.25 sec sleep was added locally 1 week ago and 0 flakes since.
Would you mind submitting it officially?

