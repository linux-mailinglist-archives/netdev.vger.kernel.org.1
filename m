Return-Path: <netdev+bounces-243350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2EFC9D8A8
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 02:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13DEF342127
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6982B22B5A5;
	Wed,  3 Dec 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZknaABqN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E612BD11
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726950; cv=none; b=ri5BlMGz6JjDYcWJ+brH2lY0KhMNsOT2kJiGS4BVO6s7iIOOFMaq4zgawyczq5qb0d2bYr+EVostQG7RflkzZ/FLDsdwKO9eEGFoOT9s6eSGTNDuZOsntOWTLLZb9WOyjkE7EMcGRE6MY1fyF1cgfPWiCfi+ZQQwnZekwcUDhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726950; c=relaxed/simple;
	bh=gybRkugXkej6YS+1H2tR0eLMheeQXzL97oE0Mvw3C0Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=TYSY3T5YQ64IE9mR8ugeJMgQWr589KKhdPXYAq66GE6lj+vNvd3w1f2TystjP8afoOrQ2+ae9RgfMJe6DEJnfg64j8nCSH6eBkGTnekY90K04CIc3zak9uvzSJ54mem3lLeHLAsOoYlXiTB1jIQPKj6agql3v2i1S73OoBQbZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZknaABqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C2AC4CEF1
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 01:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764726949;
	bh=gybRkugXkej6YS+1H2tR0eLMheeQXzL97oE0Mvw3C0Y=;
	h=Date:From:To:Subject:From;
	b=ZknaABqN0SU5Y/lLJ3yxDx1Z9AzfGUq7oYNykVWW8HBVinfzZIesfn72dDOPqwsYg
	 fO75L5QSx8ddiI3zEWXEz+vcPP+qV2G45oVZxk899V7pOJZKfzw8gokZb6KJY9x6UZ
	 qChT/LPmRdqHu8Kw0rIFtUBFz1oNNofNyFvLnDaoyXOxPByfTnbbcqvWksbh04uuAi
	 NZ7PpzO3/4jw9VGljlC3CMa8bxKiYAvDtKoSM3ZRaLMq2Ara/Xwm0eycM75i7ey7z5
	 zHNl21BA47r+DD2oCjpe1Du5w54R9hwY4XVbwbmsRW0RGiJ7jFlGTov/+mI1uX795n
	 0HteGTRmcnCQg==
Date: Tue, 2 Dec 2025 17:55:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev development stats for 6.19
Message-ID: <20251202175548.6b5eb80e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

Intro
-----

As is tradition here are the development statistics based on mailing
list traffic on netdev@vger.

These stats are somewhat like LWN stats: https://lwn.net/Articles/1004998/
but more focused on mailing list participation. And by participation
we mean reviewing code more than producing patches.

In particular "review score" tries to capture the balance between
reviewing other people's code vs posting patches. It's roughly
number of patches reviewed minus number of patches posted.=20
Those who post more than they review will have a negative score.

Previous 3 reports:
 - for 6.16: https://lore.kernel.org/20250529144354.4ca86c77@kernel.org
 - for 6.17: https://lore.kernel.org/20250728160647.6d0bb258@kernel.org
 - for 6.18: https://lore.kernel.org/20251002171032.75263b18@kernel.org=20

General stats
-------------

This release cycle was 6% smaller in terms of postings and 15% smaller=20
in terms of merged commits than 6.18. We have also regressed in terms
of review coverage.=20

Personally, this cycle felt quite busy for me. netdev foundation
received its first batch of servers, and the infrastructure has been
mostly migrated over to those (the UI still runs on the old setup but
builds and kselftests run on the shiny new machines). "We" have also
spent some time integrating the AI code review built by Chris Mason.=20

Looking ahead we are expecting more server deliveries, including some
400GE NICs for the community to experiment with. The netdev foundation
still has a good chunk of money left so please do not hesitate to
suggest how we can spend it to improve the project and help developers.

Developer rankings
------------------

Contributions to selftests:
   1 [ 30] Jakub Kicinski
   2 [ 24] Matthieu Baerts
   3 [ 13] Bobby Eshleman
   4 [  6] Carolina Jubran
   5 [  4] Kuniyuki Iwashima
   6 [  3] Eric Dumazet
   7 [  3] Breno Leitao

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 (   ) [28] Jakub Kicinski          1 (   ) [61] Jakub Kicinski     =20
   2 (   ) [21] Simon Horman            2 (   ) [41] Andrew Lunn        =20
   3 (   ) [14] Andrew Lunn             3 (   ) [38] Simon Horman       =20
   4 (   ) [ 9] Paolo Abeni             4 (   ) [21] Paolo Abeni        =20
   5 (+27) [ 5] Maxime Chevallier       5 (***) [13] Maxime Chevallier  =20
   6 ( -1) [ 5] Eric Dumazet            6 ( +1) [13] Russell King       =20
   7 ( -1) [ 5] Russell King            7 ( +6) [12] Aleksandr Loktionov=20
   8 ( +1) [ 5] Aleksandr Loktionov     8 ( -3) [12] Eric Dumazet       =20
   9 ( +3) [ 4] Jacob Keller            9 ( +3) [10] Michael S. Tsirkin =20
  10 ( -2) [ 4] Kuniyuki Iwashima      10 (+35) [10] Stefano Garzarella =20
  11 (+30) [ 3] Sabrina Dubroca        11 ( +5) [ 9] Jacob Keller       =20
  12 ( -5) [ 3] Vadim Fedorenko        12 (+14) [ 8] Sabrina Dubroca    =20
  13 (+24) [ 2] Alexander Lobakin      13 ( -5) [ 7] Kuniyuki Iwashima  =20
  14 ( +1) [ 2] Vladimir Oltean        14 (+44) [ 7] Kory Maincent (Dent Pr=
oject)
  15 ( -5) [ 2] Paul Menzel            15 (***) [ 6] Toke H=C3=B8iland-J=C3=
=B8rgensen

Lots of familiar names in top reviewer ranking. Let me focus on those
with most significant gains. Maxime has helped with various embedded
(stmmac and PHY) reviews (sorry that we didn't manage to merge the
phy_port series in time for 6.19!). Sabrina helped with TLS, IPsec,
OVPN as well as a few core changes. Stefano had his hands full with
vsock changes. Kory reviewed PSE and timestamp NDO conversion patches.
Aleksandr reviewed mostly Intel NIC patches, but occasionally also
patches for other NICs. Alexander (with an e) reviewed some of Eric's
skb optimizations.

Once again, huge thanks to those who help with patch reviews!

Top authors (cs):                    Top authors (msg):                 =20
   1 ( +1) [5] Eric Dumazet             1 (+12) [35] Christian Brauner  =20
   2 ( +1) [3] Russell King             2 (   ) [27] Russell King       =20
   3 ( -2) [3] Jakub Kicinski           3 ( +5) [19] Tariq Toukan       =20
   4 ( +2) [3] Tariq Toukan             4 (+43) [19] Bobby Eshleman     =20
   5 ( +2) [3] Heiner Kallweit          5 (+34) [18] Vadim Fedorenko    =20
   6 ( -1) [2] Alok Tiwari              6 (+27) [16] Maxime Chevallier  =20
   7 ( +8) [2] Breno Leitao             7 ( +8) [16] Daniel Golle       =20
   8 (   ) [2] Kuniyuki Iwashima        8 ( -2) [15] Eric Dumazet       =20
   9 (***) [2] Randy Dunlap             9 (+49) [14] Daniel Jurgens     =20
  10 (+29) [2] Vadim Fedorenko         10 ( -9) [13] Jakub Kicinski     =20


Top scores (positive):               Top scores (negative):             =20
   1 (   ) [412] Jakub Kicinski         1 ( +8) [135] Christian Brauner =20
   2 (   ) [306] Simon Horman           2 (+33) [ 74] Bobby Eshleman    =20
   3 (   ) [256] Andrew Lunn            3 ( +4) [ 67] Tariq Toukan      =20
   4 (   ) [144] Paolo Abeni            4 (+37) [ 58] Daniel Jurgens    =20
   5 ( +6) [ 79] Aleksandr Loktionov    5 ( +7) [ 56] Daniel Golle      =20
   6 (+32) [ 45] Sabrina Dubroca        6 (***) [ 44] Jeff Layton       =20
   7 (+12) [ 37] Michael S. Tsirkin     7 ( +9) [ 40] Eliav Farber      =20

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 ( +1) [34] RedHat                  1 ( +1) [102] RedHat            =20
   2 ( -1) [30] Meta                    2 ( -1) [ 76] Meta              =20
   3 (   ) [17] Intel                   3 ( +2) [ 44] Intel             =20
   4 (   ) [14] Andrew Lunn             4 (   ) [ 41] Andrew Lunn       =20
   5 (   ) [11] Google                  5 ( -2) [ 27] Google            =20
   6 ( +1) [ 9] nVidia                  6 ( +1) [ 20] nVidia            =20
   7 ( -1) [ 7] Oracle                  7 ( -1) [ 18] Oracle            =20

Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [12] Meta                    1 (   ) [95] Meta               =20
   2 (   ) [10] RedHat                  2 (   ) [52] RedHat             =20
   3 (   ) [10] Google                  3 ( +2) [48] nVidia             =20
   4 (   ) [ 7] Intel                   4 (   ) [47] Intel              =20
   5 ( +1) [ 7] Oracle                  5 ( +9) [41] Microsoft          =20
   6 ( -1) [ 7] nVidia                  6 ( -3) [38] Google             =20
   7 ( +1) [ 3] Huawei                  7 ( -1) [34] Oracle             =20
      =20
Top scores (positive):               Top scores (negative):             =20
   1 ( +1) [438] RedHat                 1 (+14) [137] Microsoft         =20
   2 ( +1) [256] Andrew Lunn            2 ( +9) [ 56] Daniel Golle      =20
   3 ( -2) [141] Meta                   3 ( +1) [ 50] nVidia            =20
   4 (   ) [107] Intel                  4 ( +1) [ 47] Huawei            =20
   5 ( +2) [ 38] ARM                    5 ( +7) [ 44] Amazon            =20
   6 ( +6) [ 33] Linux Foundation       6 (+23) [ 40] AMD               =20
   7 ( -1) [ 31] Google                 7 ( -4) [ 40] Pengutronix       =20
--=20
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.19/stdout

