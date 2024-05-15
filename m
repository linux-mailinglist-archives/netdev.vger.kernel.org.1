Return-Path: <netdev+bounces-96633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 182468C6CC7
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 21:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF79B20AD6
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE62915920F;
	Wed, 15 May 2024 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTk7ldrt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46683219F;
	Wed, 15 May 2024 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801153; cv=none; b=Vg6Mfop56HHFi44XTk5FdPhPD71Mk9+JUnR5Z8B3A+/rL5XNpsVlnqkqcFgxOccT92lMi47EKwtj3U/i6FjKAQAkG8t+RvOE9qHOsK/0RyKBtMkgPqPJBYUsreYGldgoMtZjUfHy7Il+f+G6jMYolxf+so6HFyYeYNt8w/DCPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801153; c=relaxed/simple;
	bh=+pQV1tr2gL7ZtCgUzkmoIRDh9F7dBK3E7xZjtXZ+irc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=c3ZFM7jZE9F1fa9YtsfZGnU5VnfTPzgGOq0eDvJhOQSBUzUEI6O1M4AgjCSke3sl635yIg2XZO4MhjzjXnrRZE1z0J+5JGQqR0wqp215vabYv7SOHEYXM6lsY1hcjznwD2G2ic1erWgEoSOKk+NvsAp0rt5YXZFQAM7fOVqL6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTk7ldrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D1AC116B1;
	Wed, 15 May 2024 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715801153;
	bh=+pQV1tr2gL7ZtCgUzkmoIRDh9F7dBK3E7xZjtXZ+irc=;
	h=Date:From:To:Subject:From;
	b=bTk7ldrtQ4vYwsRZOuvxRUx0SGOxHANJOVBfdmnQXUPw9X3GHiPC5F7FSP6MNZyRV
	 6IUgKI9lOothQwRQ83MHsEH0RhExa1XLAUP3URMM3OpY7j23XJ6xYv3TBUryAevOEX
	 fTP5AWOofn8bDgcVuu82ri6ps6p/yZlH7VuRT8Wd2CcuqD33PKtvDsMPPVj6COtF0A
	 h8QGwK3LVCEyIYDHE1z9uoU2XrhYRJG/e+Bvfi4UiDJcAWrb6Xh/9nsuUTxmI1eSVm
	 h65T3XQgpEf7J2XFkf1Mu/D/47eTnaxRMGBck0osDOb9L0CXtD9nNv9bLyu9ILilLq
	 +6Opw1nOXMUmA==
Date: Wed, 15 May 2024 12:25:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev development stats for 6.10
Message-ID: <20240515122552.34af8692@kernel.org>
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

We have posted our pull requests with networking changes for the 6.10
kernel release last night. As is tradition here are the development
statistics based on mailing list traffic on netdev@vger.

These stats are somewhat like LWN stats: https://lwn.net/Articles/956765/
but more focused on mailing list participation.

Previous stats (for 6.9): https://lore.kernel.org/all/20240312124346.5aa3b1=
4a@kernel.org/

General stats
-------------

The cycle started on Mon, 11 Mar and ended Tue, 14 May. Same length
as the previous cycle.

Mailing list volume didn't change much, we saw 266 emails a day.
Similarly the number of people discussing things on the list remained
almost unchanged.

Netdev maintainers applied 20 commits a day, which is 13% down from 6.9
(6.9 was record high, so not too alarming).

Review coverage by tags in the git repo recovered by 2%, 63% of commits
had at least one review tag, and 56% had one from a person using a different
email domain than the author.

Review coverage by number of changesets which got applied after receiving
at least one comment on the mailing list (across all revisions) dropped
to 60%.

Testing
-------

The netdev selftest runner went live during the previous release cycle.
Last time I mentioned that there were 66 ignored cases, those were either
too flaky or always failing. I'm happy to report that we got the number
down to 20. We were using results from 243 selftests at the end of 6.9
cycle, I counted 283 tests in use now, so 40 extra tests. Many of the tests
are more of test suites than single tests, for example we run full BPF CI
now, but the point is - there's growth :)

Here are top 10 individuals with the highest number of commits[*] to selfte=
sts:

   1 [ 43] Jakub Kicinski
   2 [ 42] Florian Westphal
   3 [ 23] Petr Machata
   4 [ 13] Geliang Tang
   5 [  7] Kuniyuki Iwashima
   6 [  6] Lukasz Majewski
   7 [  4] Ido Schimmel
   8 [  4] Jiri Pirko
   9 [  4] Dmitry Safonov
  10 [  2] Willem de Bruijn

[*] commits which were applied directly by netdev maintainers.

I also tried to figure out which tests give us the most signal. It's
not easy to calculate because of flakes (BTW when I say flake I usually
mean that the test fails, but passes on retry - we auto-retry all tests
run directly by NIPA).=20

I used the following criteria: overall fail rate lower than 3%, never
flaked. With that the tests which failed the most are:

   | Group                  Test                 Fail cnt
---------------------------------------------------------
 1 | vmksft-net-dbg         test-vxlan-mdb-sh          24
 2 | vmksft-net             ioam6-sh                   21
 3 | vmksft-net             test-vxlan-under-vrf-sh    20
 4 | vmksft-forwarding-dbg  q-in-vni-ipv6-sh           20
 5 | vmksft-forwarding-dbg  vxlan-asymmetric-sh        20
 6 | vmksft-forwarding-dbg  vxlan-symmetric-ipv6-sh    20
 7 | vmksft-forwarding-dbg  vxlan-symmetric-sh         20
 8 | doc-build              htmldoc                    20
 9 | vmksft-net             icmp-redirect-sh           19
10 | vmksft-forwarding-dbg  vxlan-asymmetric-ipv6-sh   19
11 | vmksft-net             big-tcp-sh                 18
12 | vmksft-net             test-vxlan-mdb-sh          18
13 | vmksft-net             test-vxlan-vnifiltering-sh 17
14 | vmksft-net-dbg         tls                        17
15 | vmksft-forwarding-dbg  dual-vxlan-bridge-sh       17

Which may or may not mean those tests caught the most bugs.

Almost exactly 1/8th of commits we applied were touching selftests
(12.51%). That doesn't seem very high.

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 ( +1) [27] Simon Horman            1 (   ) [57] Jakub Kicinski     =20
   2 ( -1) [25] Jakub Kicinski          2 (   ) [55] Simon Horman       =20
   3 ( +1) [11] Paolo Abeni             3 (   ) [35] Andrew Lunn        =20
   4 ( +2) [10] Eric Dumazet            4 ( +1) [24] Eric Dumazet       =20
   5 ( -2) [10] Andrew Lunn             5 ( +7) [20] Willem de Bruijn   =20
   6 ( -1) [ 8] Jiri Pirko              6 (   ) [19] Paolo Abeni        =20
   7 (   ) [ 5] David Ahern             7 ( -3) [17] Jiri Pirko         =20
   8 ( +1) [ 5] Willem de Bruijn        8 ( +7) [11] Jason Wang         =20
   9 ( +2) [ 3] Florian Fainelli        9 (***) [ 8] Sabrina Dubroca    =20
  10 ( +3) [ 3] Jacob Keller           10 ( -2) [ 8] David Ahern        =20
  11 ( -1) [ 3] Krzysztof Kozlowski    11 ( -4) [ 8] Krzysztof Kozlowski=20
  12 (   ) [ 3] Russell King           12 ( -1) [ 8] Russell King       =20
  13 (+20) [ 3] Dan Carpenter          13 ( -4) [ 6] Florian Fainelli   =20
  14 ( +8) [ 2] Przemek Kitszel        14 ( +7) [ 6] Serge Semin        =20
  15 (+22) [ 2] Alexander Lobakin      15 ( -1) [ 6] Jacob Keller       =20

Willem jumps into the top 5 after being quite active this month (all
over core networking and selftests), Sabrina reviewed a number of
network crypto changes (xfrm, macsec, opvpn).=20

On the "by changeset" side Jake climbs into top 10, with Przemek and
Olek also in the top 15, this is a strong cycle for Intel! Dan caught
and reported a number of bugs as well as helped to review and guide=20
bug fix contributions from others (ax25 patches most recently).

Thank you all very much for your work!


Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [9] Eric Dumazet             1 ( +1) [21] Jakub Kicinski     =20
   2 (   ) [5] Jakub Kicinski           2 ( -1) [19] Eric Dumazet       =20
   3 (***) [4] Asbj=C3=B8rn Sloth T=C3=B8nnesen   3 (***) [17] Edward Liaw =
       =20
   4 (+45) [3] Russell King             4 (***) [14] Karol Kolacinski   =20
   5 ( +2) [2] Kuniyuki Iwashima        5 (***) [14] Kory Maincent
   6 ( -3) [2] Breno Leitao             6 (***) [14] Jason Xing         =20
   7 (+43) [2] Florian Westphal         7 (***) [13] Mike Rapoport      =20
 =20
Asbj=C3=B8rn takes a high position on the author list with the improvements
to error checking in a large number of driver flower offloads.
Russell worked on converting phylink drivers to newer APIs.
(Both used a somewhat limited amount of threading when posting.)

Florian W, in addition to his usual work, moved and reworked netfilter
tests, which now run in netdev CI.

On the right side Mike R and Edward L are "non netdev people" who just
CCed netdev on their large series.


Top scores (positive):               Top scores (negative):             =20
   1 ( +1) [395] Simon Horman           1 (***) [67] Edward Liaw        =20
   2 ( -1) [351] Jakub Kicinski         2 (***) [58] Karol Kolacinski   =20
   3 (   ) [176] Andrew Lunn            3 (***) [55] Kory Maincent (Dent Pr=
oject)
   4 ( +1) [158] Paolo Abeni            4 (***) [52] Mike Rapoport      =20
   5 ( -1) [111] Jiri Pirko             5 (***) [44] Asbj=C3=B8rn Sloth T=
=C3=B8nnesen
   6 ( +2) [109] Willem de Bruijn       6 ( -4) [38] Xuan Zhuo          =20
   7 (+32) [ 99] Eric Dumazet           7 (+37) [36] Mateusz Polchlopek =20
   8 ( -1) [ 70] David Ahern            8 (+14) [36] Oleksij Rempel     =20
   9 ( +8) [ 49] Jason Wang             9 ( +1) [34] Breno Leitao       =20
  10 ( +3) [ 47] Jacob Keller          10 (+18) [33] Michal Swiatkowski =20

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 (   ) [41] RedHat                  1 (   ) [106] RedHat            =20
   2 (   ) [30] Meta                    2 (   ) [ 81] Meta              =20
   3 (   ) [17] Google                  3 ( +1) [ 55] Google            =20
   4 ( +1) [16] Intel                   4 ( +1) [ 43] Intel             =20
   5 ( +1) [11] nVidia                  5 ( -2) [ 35] Andrew Lunn       =20
   6 ( -2) [10] Andrew Lunn             6 ( +1) [ 30] nVidia            =20
   7 (   ) [ 8] Linaro                  7 ( -1) [ 18] Linaro            =20

Top authors (cs):                    Top authors (msg):                 =20
   1 ( +2) [14] Intel                   1 (   ) [86] Intel              =20
   2 ( -1) [13] RedHat                  2 ( +1) [60] Google             =20
   3 ( +1) [12] Google                  3 ( +2) [52] RedHat             =20
   4 ( -2) [10] Meta                    4 (   ) [46] nVidia             =20
   5 (   ) [ 6] nVidia                  5 ( -3) [45] Meta               =20
   6 (***) [ 4] Asbj=C3=B8rn Sloth T=C3=B8nnesen  6 ( +1) [29] Alibaba     =
       =20
   7 ( +3) [ 3] Amazon                  7 (+16) [20] Linaro             =20

Top scores (positive):               Top scores (negative):             =20
   1 (   ) [500] RedHat                 1 ( +1) [86] Alibaba            =20
   2 (   ) [359] Meta                   2 (+12) [65] Huawei             =20
   3 (   ) [176] Andrew Lunn            3 ( +5) [58] Intel              =20
   4 ( +1) [110] Google                 4 (***) [55] Dent Project
   5 ( +1) [ 70] Enfabrica              5 (+45) [44] Asbj=C3=B8rn Sloth T=
=C3=B8nnesen
   6 ( +1) [ 53] Oracle                 6 ( -5) [38] Bootlin            =20
   7 ( -3) [ 47] Linaro                =20
--=20
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.10/stdout

