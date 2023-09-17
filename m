Return-Path: <netdev+bounces-34354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61DC7A3646
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 17:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941FA1C217B8
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F071848;
	Sun, 17 Sep 2023 15:31:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DA23BD
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 15:31:20 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF730EA;
	Sun, 17 Sep 2023 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1694964602; x=1695223802;
	bh=xCV78BUZ8wWHYIMMcO4tVeNrAYJwIdS9yFfArGxbUqA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SlYa5y0afeSTQ5KzBpULSlj2qXsKFgdjTpp1DG0YPGM4HMdCUYVv4dP0OvGEYP5RA
	 yohGBk3IXf1bbJbS9t2hPRn83JJYrRT87gPT/NcU/lJJ48SvJ4PTcU8eCwpWs8XgVS
	 XAqtGOtHdI6AEgHp2/DIADoUFw9mhE6Kg5hRZtqGB9eOcz+pKDU2DuZM3OC+ob73nI
	 ArOJAmIq2vawDVdTXqzJEGL1hTILJWo0+UU2bREmvch4jsKArc5e6TcELRiw7JCJ/F
	 mYkJBtz+a3BNI31VIjzPLTqTZf3rwGOPBarfAy7qdj3deHDavwmi+rhLTRy3LhUOE2
	 r9JFxlfirtlBw==
Date: Sun, 17 Sep 2023 15:29:44 +0000
To: linux-hams@vger.kernel.org
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: Peter Lafreniere <peter@n8pjl.ca>, thomas@osterried.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ralf@linux-mips.org, linux-doc@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 0/3] ax25: Update link for linux-ax25.org
Message-ID: <20230917152938.8231-1-peter@n8pjl.ca>
In-Reply-To: <20230908113907.25053-1-peter@n8pjl.ca>
References: <20230908113907.25053-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

http://linux-ax25.org has been down for nearly a year. Its official
replacement is https://linux-ax25.in-berlin.de.

Update all references to the dead link to its replacement.

As the three touched files are in different areas of the tree, this is
being sent with one patch per file.

Peter Lafreniere (3):
  Documentation: netdev: fix dead link in ax25.rst
  MAINTAINERS: Update link for linux-ax25.org
  ax25: Kconfig: Update link for linux-ax25.org

 Documentation/networking/ax25.rst |  4 ++--
 MAINTAINERS                       |  6 +++---
 net/ax25/Kconfig                  | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

--=20
2.42.0



