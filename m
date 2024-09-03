Return-Path: <netdev+bounces-124757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9296ACC3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE011C233D9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45621D5CE9;
	Tue,  3 Sep 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/uoLkbI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737751B9827;
	Tue,  3 Sep 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405740; cv=none; b=nIvgGs6CK0xJ8Qot+BJ1M4CWaCrUvEDnmykuh2cUej1aSEpmF8dV+pc/oLRt68WKq+L9UXxvpa12BKjiKDD2moaFEyVK6VurWxhvDJk185L+NAcVeynKHNBwXMiJuclh499wp0GuPV+39d5XtGeFyzM7lE+JzkK19gtMAlmN0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405740; c=relaxed/simple;
	bh=av3z+vaClYidGmAb0yzoWOKsvSWaukTGv6M4zlfRSgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Au88DCwRtTGS91odxOYb3yVR2o6fsGpBd6+AHHy0zQ4UyIjRr2JO7r0PfWSFQEXc3yukKCbyh6qr/e4LQGkd97+CUs1ZnqqN2TwUOL6vm1mpf2cAVoyZPbub4cHIMMPFKCP1SpxbV1eKmb0DUVwZEIbZDwMhATgohWXEd1bgrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/uoLkbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2E4C4CEC4;
	Tue,  3 Sep 2024 23:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725405740;
	bh=av3z+vaClYidGmAb0yzoWOKsvSWaukTGv6M4zlfRSgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r/uoLkbI+iu6XVaKjUM12pLFCdhMt9I9HOnPmfWvgXrCNJ93rWBSt38XM/2LK1EKw
	 H+gN6Fv9p5B3tqGnpfAztmsBZ6U6/0o7k2+R3wwEBIygFeOyEHlW5K9+Z5SMBPj8qn
	 BbVyUeeMww7CfaPFKcWihXhkNWthDF0KUY1B+PoUTI0TdzKMDlsYsKd2Uc7mkGtyge
	 jJxiOObEM9AEvduBFjlYwMljj52YFboogFj6bXtTKZy+vxcu7XKx5ycbISq5Z5730J
	 djZigoXzjSfljGOHuR8wK6S9mV0aoLWECwy/w/gJUiEZ5s+WPs1+S+Uj1uU0vYk0LL
	 TPTLsdKW/mPSw==
Date: Tue, 3 Sep 2024 16:22:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] selftests: mptcp: add time per subtests in
 TAP output
Message-ID: <20240903162217.07c366c9@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
References: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Sep 2024 13:13:03 +0200 Matthieu Baerts (NGI0) wrote:
> Patches here add 'time=<N>ms' in the diagnostic data of the TAP output,
> e.g.
> 
>   ok 1 - pm_netlink: defaults addr list # time=9ms

Looking closer, this:

# ok 3 - mptcp[...] MPTCP # time=7184ms
# ok 4 - mptcp[...] TCP   # time=6458ms

Makes NIPA unhappy. The match results for regexps look like this:

(None, '4', ' -', 'mptcp[...] MPTCP', ' # ', 'time=6173ms')
(None, '4', ' -', 'mptcp[...] TC', None, 'P   # time=6173ms')

IOW the first one is neat, second one gepooped. The regex really wants
there to be no more than a single space before the #. KTAP definition
doesn't say that description must not have trailing white space.

Best I could come up with is:

diff --git a/contest/remote/vmksft-p.py b/contest/remote/vmksft-p.py
index fe9e87abdb5c..a37245bd5b30 100755
--- a/contest/remote/vmksft-p.py
+++ b/contest/remote/vmksft-p.py
@@ -73,7 +73,7 @@ group3 testV skip
     tests = []
     nested_tests = False
 
-    result_re = re.compile(r"(not )?ok (\d+)( -)? ([^#]*[^ ])( # )?([^ ].*)?$")
+    result_re = re.compile(r"(not )?ok (\d+)( -)? ([^#]*[^ ])( +# )?([^ ].*)?$")
     time_re = re.compile(r"time=(\d+)ms")
 
     for line in full_run.split('\n'):

Thoughts?

