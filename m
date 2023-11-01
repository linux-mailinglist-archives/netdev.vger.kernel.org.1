Return-Path: <netdev+bounces-45610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6D7DE8D5
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 00:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAA628125D
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD41A282;
	Wed,  1 Nov 2023 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMI/iuWp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F251FCA
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 23:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B76C433C9;
	Wed,  1 Nov 2023 23:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698881348;
	bh=aqnm14PVwxxCdtqep0nLSvJD0qhGE1YQ5xqmea1ksDI=;
	h=Date:From:To:Cc:Subject:From;
	b=JMI/iuWp+0+aWp2uZMeSFSsZsiREEZrz1e4ZIxWdvImtEYcsrHPHjhsS0RE8N400R
	 TZ8T5e+aNAQDKHngATmVeT6XnrE9UFpTQ6aHGApj5ozsadvlFv+OlaCNfmDAtRX34W
	 +/YYxwav0sSWiFWnGbYfwzNw8t5eJVADvdSd51w1ETIWvTLIPzJS6sKYec3BRf1IVS
	 K1jrWgRHMVC/X9PNNwhnkf36hTaSkF739UlymSYP5rPYyHRT6u7lzESr0LIsuIUgLb
	 3WfKLeSYpVX5g7tIaY8MUhyUVokq3mg8alZeHm+oWKfbslI+BXA6PniZ52iX7o+ZMY
	 Fp+f14Bs6/bTg==
Date: Wed, 1 Nov 2023 16:29:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: netdev-driver-reviewers@vger.kernel.org, Stanislav Fomichev
 <sdf@fomichev.me>
Subject: [ANN] netdev development stats for 6.7
Message-ID: <20231101162906.59631ffa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

General stats
-------------

The cycle started on August 29th and ended on Oct 31st, 1 day shorter
than previous one, due to the timing of our PR.

We have seen total of 14243 messages on the list (226 / day) which=20
is 17% lower than the (very busy) 6.6 cycle. The number of commits
directly applied by netdev maintainers dropped by 13% to 19 commits=20
a day, close to our long term average.

There was a fluctuation in the number of participants. While the number
of people "reviewing" (replying in threads) remained constant (around
410) the number of people exclusively starting threads ("authors"?)
decreased by 40 (344 -> 306).

Fraction of changes with Review/Ack tags has dropped again to 58%
(counting all tags) and 50% (counting tags from different company
than the author).

Rankings
--------

Top reviewers (thr):                 Top reviewers (msg):               =20
   1 (   ) [24] Simon Horman            1 ( +1) [43] Jakub Kicinski     =20
   2 (   ) [23] Jakub Kicinski          2 ( -1) [33] Simon Horman       =20
   3 (   ) [12] Andrew Lunn             3 (   ) [33] Andrew Lunn        =20
   4 ( +1) [10] Paolo Abeni             4 ( +5) [15] Eric Dumazet       =20
   5 ( +1) [ 8] Eric Dumazet            5 ( +1) [14] David Ahern        =20
   6 ( +1) [ 7] David Ahern             6 ( +2) [13] Paolo Abeni        =20
   7 (+21) [ 7] Kees Cook               7 (+21) [13] Florian Fainelli   =20
   8 (+12) [ 6] Jiri Pirko              8 ( +5) [12] Jiri Pirko         =20
   9 (+14) [ 6] Florian Fainelli        9 (+23) [12] Jacob Keller       =20
  10 (+19) [ 6] Jacob Keller           10 ( +8) [10] Vladimir Oltean    =20
  11 ( -2) [ 4] Russell King           11 (+24) [ 9] Kees Cook          =20
  12 ( -2) [ 4] Willem de Bruijn       12 ( +5) [ 8] Rob Herring        =20
  13 ( +2) [ 4] Vladimir Oltean        13 ( -8) [ 8] Russell King       =20
  14 ( -1) [ 4] Rob Herring            14 ( +1) [ 8] Jason Wang         =20
  15 (***) [ 3] Wojciech Drewek        15 ( -4) [ 7] Willem de Bruijn   =20

No surprises in the top 6. Kees takes #7, helping to review string op
safety and __conted_by patches. Wojciech enters the ranking at #15.
Thanks for all the review work, folks!

Top authors (thr):                   Top authors (msg):                 =20
   1 (***) [7] Justin Stitt             1 ( +3) [18] Eric Dumazet       =20
   2 ( +1) [6] Eric Dumazet             2 (***) [16] David Howells      =20
   3 ( -1) [6] Jakub Kicinski           3 ( +6) [16] Dmitry Safonov     =20
   4 (+10) [3] Jiri Pirko               4 ( -2) [14] Saeed Mahameed     =20
   5 ( -1) [2] Tony Nguyen              5 ( +9) [14] Herve Codina       =20
   6 (***) [2] Oleksij Rempel           6 (   ) [13] Jiri Pirko         =20
   7 (***) [2] Kees Cook                7 ( -4) [12] Jakub Kicinski     =20
   8 (***) [2] Ivan Vecera              8 (+26) [11] Aurelien Aptel     =20
   9 (***) [2] Dan Carpenter            9 ( -8) [11] Tony Nguyen        =20
  10 (+15) [2] MD Danish Anwar         10 (***) [10] Uwe Kleine-K=C3=B6nig =
  =20

Justin has posted the most individual patches, replacing the use of
unsafe string APIs throughout the drivers. Jiri jumps into top 5
with his devlink and YNL work. David H posted a few series for iov
and network file systems (somewhat netdev-adjacent). Dmitry contributed
the TCP Auth Option support. Herve worked on a HDLC framer for QMC.=20

Top reviewers (thr):                 Top reviewers (msg):               =20
   1 ( +2) [42] RedHat                  1 ( +2) [71] RedHat             =20
   2 (   ) [27] Meta                    2 ( -1) [52] Meta               =20
   3 ( +2) [23] Intel                   3 ( +2) [46] Intel              =20
   4 ( +2) [15] Google                  4 ( +2) [33] Andrew Lunn        =20
   5 ( -1) [12] nVidia                  5 ( +2) [29] Google             =20
   6 ( +1) [12] Andrew Lunn             6 ( -2) [23] nVidia             =20
   7 ( +3) [ 7] Enfabrica               7 ( +4) [14] Broadcom           =20

The biggest change in the company statistics is the disappearance
of Corigine. Simon is now employed at Red Hat, giving Red Hat the
#1 spot with quite some margin.

With Corigine dropping out, Enfabrica (David Ahern) and Broadcom
(Florian Fainelli) ascend to the top #7.

Top authors (thr):                   Top authors (msg):                 =20
   1 ( +5) [22] Google                  1 (   ) [76] Intel              =20
   2 (   ) [19] Intel                   2 (   ) [59] nVidia             =20
   3 (   ) [17] RedHat                  3 (   ) [55] RedHat             =20
   4 (   ) [10] Meta                    4 ( +2) [50] Google             =20
   5 (   ) [ 9] nVidia                  5 (   ) [38] Meta               =20
   6 ( -5) [ 6] Huawei                  6 (+10) [26] Bootlin            =20
   7 ( +6) [ 5] Linaro                  7 ( -3) [23] Huawei      =20

Top scores (positive):               Top scores (negative):             =20
   1 ( +3) [341] RedHat                 1 (+13) [97] Bootlin            =20
   2 (   ) [219] Meta                   2 (***) [72] nVidia             =20
   3 (   ) [183] Andrew Lunn            3 ( -2) [66] Huawei             =20
   4 ( +2) [ 95] Enfabrica              4 ( +4) [59] Arista             =20
   5 ( +4) [ 59] Broadcom               5 (+10) [48] Alibaba            =20
   6 (+17) [ 52] Isovalent              6 (***) [41] Pengutronix        =20
   7 ( +3) [ 47] ARM            =20
   8 ( +5) [ 46] Oracle            =20
   9 ( -1) [ 44] Linux Foundation =20
  10 ( -5) [ 32] Linaro        =20

A few things worth noting in the "community score" metrics.

Intel moved from the "negative" to the "positive" side (at #13, so not
high enough to make the "top"). Shout out to Jake, Wojciech and Przemek
for their review work! This move may have been helped slightly by the
lower volume of Intel patches and external contributions to Intel
drivers. So please do not rest on your laurels :)

nVidia makes the opposite switch and ironically takes negative spot #2,
the exact spot previously occupied by Intel. Jiri's efforts are not
enough to counter balance the flow of patches there :(

Arista is likely a blip as Dmitry had to repost his work a few times.

Bootlin and Pengutronix return to the same (negative) positions they
held in 6.5 cycles. It may be the time to carve out more review time
for folks working at those companies.
--=20
Code: https://github.com/kuba-moo/ml-stat

