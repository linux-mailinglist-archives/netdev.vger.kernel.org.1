Return-Path: <netdev+bounces-14994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CEB744E06
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3C51C20750
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026A02104;
	Sun,  2 Jul 2023 14:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A042101
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 14:04:23 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D21A2;
	Sun,  2 Jul 2023 07:04:22 -0700 (PDT)
User-agent: mu4e 1.10.4; emacs 29.0.92
From: Sam James <sam@gentoo.org>
To: regressions@leemhuis.info
Cc: Jason@zx2c4.com,andy@greyhouse.net,bagasdotme@gmail.com,boqun.feng@gmail.com,boris.ovstrosky@oracle.com,bp@alien8.de,dave.hansen@linux.intel.com,david@unsolicited.net,eric.devolder@oracle.com,hpa@zytor.com,j.vosburgh@gmail.com,joel@joelfernandes.org,lenb@kernel.org,linux-acpi@vger.kernel.org,linux-kernel@vger.kernel.org,manuel.leiner@gmx.de,miguel.luis@oracle.com,mingo@redhat.com,netdev@vger.kernel.org,paulmck@kernel.org,rafael@kernel.org,rcu@vger.kernel.org,regressions@lists.linux.dev,tglx@linutronix.de,wireguard@lists.zx2c4.com,x86@kernel.org
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux
 6.3.0+
In-Reply-To: <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
Date: Sun, 02 Jul 2023 15:03:36 +0100
Message-ID: <87sfa6if4x.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#regzbot link: https://bugs.gentoo.org/909066

