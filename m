Return-Path: <netdev+bounces-15004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40723744EAF
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 18:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0ED51C20839
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9328FC;
	Sun,  2 Jul 2023 16:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B355210B
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 16:55:46 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C258F;
	Sun,  2 Jul 2023 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688316915; x=1688921715; i=markus.elfring@web.de;
 bh=flCzFl53mqj6HfIawDN80wtxO3NXIioPCQrUVTp1EYI=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=JsHzxxFVaF3cqTVwPVbTOlE1oh8GZORb2Dm9tRDL0/IfimGupkrUrtMPsN3uoM0QSi0u8T3
 ynl7BDA4nZ+3z9AcHVdOqV2ycgoITgNl3AQ4kYTrcRkaG7//mRtUnv+4TQ0Vx/03YjMaghGc5
 Odp6WMCIaakJ65cT7WoHKUBNRSiIxraDkXptrAEqX0rB8ziWGTyBaabQ/fOJznH80DInm9MVK
 gBEHO46+tmx7Fti4307bECGv8+Tq1zGB01lKhsRMFHHCo4qYSYwNDbWymlEx1Wi70y+twV17l
 V71OtLcjKaqhcmxUwL4giQh6Pb14+hvi6zKyTB982pu6Nwg2Vq8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MD5jp-1q6tX82n5t-009FDB; Sun, 02
 Jul 2023 18:55:15 +0200
Message-ID: <36b57ea5-baff-f964-3088-e1b186532cfe@web.de>
Date: Sun, 2 Jul 2023 18:55:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Florian Kauer <florian.kauer@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>,
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Tan Tee Min <tee.min.tan@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230619100858.116286-2-florian.kauer@linutronix.de>
Subject: Re: [PATCH net v2 1/6] igc: Rename qbv_enable to
 taprio_offload_enable
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230619100858.116286-2-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:auUCEvWT9WvifEoSMz9upWpehnvmnhoa6/XeYqOPnfX1djLeSSf
 Nh7dH5eT9Ja6LCI17HDSUI5+B4nmOnkVlAT0pYVjQXoxPsGvB+62BmSgAo2Klnzx+fIlN5j
 0q60j4Q5A/EK8yUat5A9HsdONfeaBXvy52E82NoXqoyWiWsku4JUDFfJLlBcIme0ACwyD8f
 aIqIrfIiaim8iQFCVm0CA==
UI-OutboundReport: notjunk:1;M01:P0:sjw33rJnVBo=;Zg1GKobS4Zg5YuHttsqke7sY9Jz
 156KPv3ly5kUq3jg6+Md6SWth+Pq7bvOZNA1p4xtV1+ayNDq4d4UsMubBRRqp4d5t3nXC24c9
 2uqzjQ4D8WtQLEJPRkG8mvX+bTopsth2fjyhRreC0R49esHgMNtmpLFV/BVVJ4X3CfEuQekBq
 IMYSoq6BoyOieMEmfi+hb9OBEd1VPcERQjmKnj1Vv7JKl7tXvzLb4SqV2SSprJy5YOllU/FEC
 1Qz3V91WN4Diw7hHMPVBSqN6UuNEEcx53kpeZMwpNO90O9oWeztqQO4ISe5RAx7/7zd+d1+gj
 FF1UL3rxa7QHynamjltydWmZfkwCMneZz1z9QpwLRlcUtPBHwc3EzbiYxOuTrRa0PTAvms+LZ
 uKrf+u+wrt82LO8bC1iZPCY8dBSxvmPHW6VJZNBKMoGmHcST983n3KiVi0evjw0UW5Upii75S
 IIsq1jJ129x38DVpVI+4b2ge9fChFLFZABDpQiR1kHPenAtYBIsaC8UW7YRxoLoJFIZbk4Zby
 OqJ5oU+8JwltqhlVAjvHSIu3fSDzBL1pv1t9U7vuLpD3qzyP5zcJzVpJFUOemoO7pQnJw9i84
 Ff0aWroY0BVmJmuf+YaLmkdFxq7RuJ2gl3u6IVhpNW520moF1cNCAzhGMLFPcGhE8IvpFYvBL
 bL7boZbL2PZEMBPSeZpm51NmzevPS5G2njlGVODOPasyYJ1idp1x54HQ7uC30o1b7H6uIK/Gp
 ikuQndxZHY9JrkoJr+7JdxIwxGqe09KF1+G/MiGgsMxx4OYQAhPCsGJbO2JGDbdbg35eH8iuz
 Ov7OGZb8p2PO6nsJtVRqs8zmkpK0aWv3WqcoByYgwudXz6PejN2jVm3RwArMsZACF+H/HJqPH
 jnuiqNYp47yyfCrjHPWHfiTbZ3yUrGACB2sJwp4kwtNod2oVrS9Y9zwHzrky3jAaxi/erURLI
 yOKjeEtV7E2zvMcAKfBPRqpZnKs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The rename should reduce this confusion.

Would the wording =E2=80=9CReduce this confusion by renaming a variable at=
 three places=E2=80=9D
be more appropriate for a subsequent change description?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4#n94


>                                          Since it is a pure
> rename, it has no impact on functionality.
>
> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")

How does such information fit together?

Regards,
Markus

