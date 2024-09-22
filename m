Return-Path: <netdev+bounces-129192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FD397E29C
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF731C2105E
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6A27701;
	Sun, 22 Sep 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU+/KH5i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295522338;
	Sun, 22 Sep 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024493; cv=none; b=Dm5bLkZbfvB+iVDmUjc7Np+2YjzGT7I+is+UVQ+ugeWTAHzQFEiaD1QDnfjn5bj702/0+ig7uRiV1D+K2z6OCJNevxaDbTXocn4Q4ErNqOBxBv76/gDYgAv2ZuqT7/c3nLMHFo8ysynsV4mkfuzIm661PHS6ZA5QJJSOaM0twQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024493; c=relaxed/simple;
	bh=HNuthrvwkOtbE+yG0jh/SwV2lyVBPwXEzDIWVplfXHw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=QQcO6gnHWg2TrvDmw4r9oouFof2nWROvw72KWPNuV7Fbo5owmWjPRBmSoyuekjK5GhlFSqiess3G3xNRuL4fRwnW9Gx3k7jVyjY6MHArgk9wh2UAB+IdXUz3pl8LYttiXfaMtMeqVTmHyTjM3XMMCezxC7vHP+VZcg/yJGcpYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU+/KH5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A61C4CEC3;
	Sun, 22 Sep 2024 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727024493;
	bh=HNuthrvwkOtbE+yG0jh/SwV2lyVBPwXEzDIWVplfXHw=;
	h=Date:From:To:Subject:From;
	b=QU+/KH5i2wcaqeK/zvv3IrJlrJYGqiooJ+eXo6Oxe4+4at0nlKa3hoQCdecPIm1V5
	 RYzf09yM8J0sv8At6zbXZRqUdgFj5j4BfO+ERc0XGFgixkzwIkjofgRuddpAhwmiuy
	 NSq013QFv0OwqVrY8Kxwgo7J7PS6BqHMw2NmQKBqGlswkFaorA8DE0Uvf7nJIcU/Te
	 eCTmW/Wm2LeDOCBi7oM9Wu/sdGePh+6iH2h075mUtpbB/rwZglkpg1dyAqGTgKBKXE
	 YdWtO/A9Jp5rHevqmN11y4YHzqz/f3GXmUy+36guVrA2p5RyrWmwgDNcu4OyvC2Xyo
	 Ig6LgJZvhQxhw==
Date: Sun, 22 Sep 2024 19:01:25 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.12
Message-ID: <20240922190125.24697d06@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Intro
-----

As is tradition here are the development statistics based on mailing
list traffic on netdev@vger. The posting is slightly delayed due to
LPC and netconf, sorry about that!

These stats are somewhat like LWN stats: https://lwn.net/Articles/956765/
but more focused on mailing list participation.

Previous stats (for 6.11): https://lore.kernel.org/20240722142243.26b9457f@=
kernel.org

General stats
-------------

The 6.12 cycle was 1 day shorter than previous cycle (due to LPC).=20
The mailing list traffic was slightly above average (269 msg/day),
returning to normal after a dip during the 6.11 cycle. netdev
maintainers applied 19 commits a day, which is fairly typical and
recovered from a slight decrease.

Number of patches applied with review tags increased to record 71%
(57.5% when we exclude folks working for the same company). Number of
patch sets applied without any comments on the list (across revisions)
remained at 30%.

Testing
-------

We merged a similar number of changes to selftests (106, up from 104).

Number of ignored (flaky) tests in our CI continues to drop:
 - 6.10: 20
 - 6.11: 14
 - 6.12:  8

The ranking of people who contributed most to selftests:

   1 [ 31] Matthieu Baerts
   2 [  9] Ido Schimmel
   3 [  8] Vladimir Oltean
   4 [  7] Dmitry Safonov
   5 [  6] Petr Machata
   6 [  6] Jakub Kicinski
   7 [  5] Willem de Bruijn
   8 [  4] Abhinav Jain
   9 [  3] Jason Xing
  10 [  3] Hangbin Liu

Matthieu contributed a lot to MPTCP selftests, including the ability=20
to report test case execution time. Willem added first two batches of
packetdrill tests, and associated infra. Ido added tests for DSCP FIB
rule matching, Petr for 16b ECMP weights.

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 (   ) [31] Jakub Kicinski          1 (   ) [72] Jakub Kicinski     =20
   2 (   ) [30] Simon Horman            2 (   ) [54] Simon Horman       =20
   3 (   ) [16] Andrew Lunn             3 (   ) [46] Andrew Lunn        =20
   4 (   ) [ 9] Paolo Abeni             4 (   ) [19] Eric Dumazet       =20
   5 (   ) [ 9] Eric Dumazet            5 ( +2) [16] Willem de Bruijn   =20
   6 ( +1) [ 5] Krzysztof Kozlowski     6 ( -1) [12] Paolo Abeni        =20
   7 ( +5) [ 4] Willem de Bruijn        7 ( +1) [12] Krzysztof Kozlowski=20
   8 ( +7) [ 4] Rob Herring             8 ( +7) [10] Jiri Pirko         =20
   9 ( +1) [ 4] Jacob Keller            9 (   ) [ 8] Michael S. Tsirkin =20
  10 ( +9) [ 3] Greg KH                10 ( +2) [ 8] Jacob Keller       =20
  11 ( -5) [ 3] Przemek Kitszel        11 (+23) [ 8] Alexander Lobakin  =20
  12 ( +4) [ 3] Kuniyuki Iwashima      12 (***) [ 8] Guillaume Nault    =20
  13 (+45) [ 2] Florian Westphal       13 ( +7) [ 7] Greg KH            =20
  14 (+11) [ 2] Florian Fainelli       14 (***) [ 7] Micka=C3=ABl Sala=C3=
=BCn     =20
  15 (+20) [ 2] Marc Kleine-Budde      15 ( -9) [ 7] Vladimir Oltean    =20

Big thanks to all the reviewers for their invaluable work!


Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [4] Jakub Kicinski           1 (+20) [26] Marc Kleine-Budde  =20
   2 (+34) [3] Simon Horman             2 (+11) [24] Tony Nguyen        =20
   3 (***) [3] Rosen Penev              3 ( +3) [17] Mina Almasry       =20
   4 (***) [2] Mina Almasry             4 (***) [16] Jijie Shao         =20
   5 ( -3) [2] Eric Dumazet             5 ( -3) [15] Jakub Kicinski     =20
   6 (+10) [2] Matthieu Baerts          6 (+33) [15] Matthieu Baerts    =20
   7 (***) [2] Jinjie Ruan              7 ( -2) [13] Yunsheng Lin       =20


Top scores (positive):               Top scores (negative):             =20
   1 ( +1) [462] Jakub Kicinski         1 (+13) [81] Tony Nguyen        =20
   2 ( -1) [428] Simon Horman           2 (+34) [71] Marc Kleine-Budde  =20
   3 (   ) [292] Andrew Lunn            3 (***) [62] Jijie Shao         =20
   4 ( +1) [131] Eric Dumazet           4 (   ) [56] Mina Almasry       =20
   5 ( -1) [ 83] Paolo Abeni            5 ( -2) [51] Yunsheng Lin       =20
   6 ( +1) [ 71] Krzysztof Kozlowski    6 ( +7) [50] Christian Hopps    =20
   7 ( +1) [ 69] Willem de Bruijn       7 (***) [41] Rosen Penev        =20
   8 ( +8) [ 57] Greg KH                8 (***) [41] Parthiban Veerasooran
   9 ( +2) [ 55] Rob Herring            9 (***) [38] Saeed Mahameed     =20
  10 (+14) [ 50] Jacob Keller          10 (***) [38] Jinjie Ruan        =20


Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 (   ) [45] RedHat                  1 (   ) [103] RedHat            =20
   2 (   ) [33] Meta                    2 (   ) [ 94] Meta              =20
   3 (   ) [16] Intel                   3 ( +2) [ 53] Google            =20
   4 (   ) [16] Andrew Lunn             4 (   ) [ 46] Andrew Lunn       =20
   5 (   ) [15] Google                  5 ( -2) [ 44] Intel             =20
   6 ( +1) [ 7] Linaro                  6 (   ) [ 23] nVidia            =20
   7 ( -1) [ 7] nVidia                  7 (   ) [ 18] Linaro            =20

Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [11] RedHat                  1 (   ) [69] Intel              =20
   2 (+13) [ 9] Huawei                  2 ( +5) [68] Huawei             =20
   3 ( +1) [ 8] Google                  3 ( -1) [53] RedHat             =20
   4 ( -1) [ 7] Meta                    4 ( -1) [43] nVidia             =20
   5 ( -3) [ 7] Intel                   5 (   ) [37] Meta               =20
   6 ( -1) [ 5] nVidia                  6 (+12) [32] Pengutronix        =20
   7 ( -1) [ 4] Linaro                  7 ( -3) [29] Google               =
=20

Top scores (positive):               Top scores (negative):             =20
   1 (   ) [523] RedHat                 1 ( +1) [250] Huawei            =20
   2 (   ) [457] Meta                   2 (+19) [ 66] Pengutronix       =20
   3 (   ) [292] Andrew Lunn            3 ( +7) [ 50] LabN              =20
   4 (   ) [184] Google                 4 (***) [ 41] Minerva Networks  =20
   5 (   ) [102] Linaro                 5 ( +7) [ 40] nVidia            =20
   6 ( +1) [ 68] Linux Foundation       6 (+26) [ 37] NGI0 Core         =20
   7 ( -1) [ 59] ARM                    7 (***) [ 36] Microchip         =20
--=20
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.12/stdout

