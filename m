Return-Path: <netdev+bounces-239614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C9C6A3FB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 246762B457
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7E35BDCE;
	Tue, 18 Nov 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkA+kAcq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9C35B156
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478786; cv=none; b=UjzMxo8Pa4ukdpBo8GV719zedYH1qDmSNSpbnkbdUgeckorMcM6ROjx2kxSE9LWBJv24F4+TrynC0y/IO2puRPHZ3nSFaOoBIOgsZVS7A6PM6fXWcmjF4sjN9XbrtrlDQiGrE7WEez0UyCur8/Ir7DXh1gCixy08Ben0PQYHhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478786; c=relaxed/simple;
	bh=7/K/27kceO6kdj+QE3P8Len9W/Mt0UWFnTS79T5e5cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3PGJAY5JpyAtEoDFUW3g34ualce3PuC33uFscrxDhzpIRWk/XAkaX/dGVCpvxnu5/qvSJ76qX46N+6AVd6A/eYwTA7GBoU29hJ2z5pCeh4nst6jrSEy8WHVzGI3tlOoimMq2K/pvWDwsw9d5YKQtSvGMjEvkWDwoPpXB+cRnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkA+kAcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE7C4CEF5;
	Tue, 18 Nov 2025 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763478783;
	bh=7/K/27kceO6kdj+QE3P8Len9W/Mt0UWFnTS79T5e5cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HkA+kAcqxLs784UzJBnDm23uzg+Hv66ALnuoG1dpCYVMrZhyy3kdow5JT5Ccjby0N
	 aRB2cqIBor8m6XHc4r/9GPDRHg2MIyLdwmmNgRSqHEN+VH8eM/THPWohxs0xTRGVfa
	 RN+Yex9S5H5sCSob2rg3576t1SQetRCpJnAXOoQziADyLyg7KF2bgC0TNl7n4JhK3v
	 SP225G/Hnt2ofipp8WqLN1b+GbSqt1UXP8W6YCLrA1HV3t4Q/ZzUHWLLUb1c2VMSh/
	 fjqAuqYPLX3q2jLyMjiweqfu1swDm1sCETxc9I06+yvtZNzHFnqRdb9n91mAL56e6y
	 PQd4QDX/7zBYQ==
Date: Tue, 18 Nov 2025 07:13:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <20251118071302.5643244a@kernel.org>
In-Reply-To: <aRwMJWzy6f1OEUdy@fedora>
References: <20251114082014.750edfad@kernel.org>
	<aRrbvkW1_TnCNH-y@fedora>
	<aRwMJWzy6f1OEUdy@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 06:03:17 +0000 Hangbin Liu wrote:
> > Hmm, this one is suspicious. I can reproduce the ping fail on local.
> > But no "otherhost" issue. I will check the failure recently.  
> 
> This looks like a time-sensitive issue, with
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> index c4711272fe45..947c85ec2cbb 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> @@ -30,6 +30,7 @@ check_connection()
>         local message=${3}
>         RET=0
> 
> +       sleep 1
>         ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
>         check_err $? "ping failed"
>         log_test "${bond_mode}/${xvlan_type}_${xvlan_mode}: ${message}"
> 
> I run the test 100 times (vng with 4 cpus) and not able to reproduce it anymore.
> That maybe why debug kernel works good.

I see. I queued up a local change to add a 0.25 sec wait. Let's wait 
a couple of days and see how much sleep we need here, this function 
is called 96 times if I'm counting right.

