Return-Path: <netdev+bounces-17896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3533A753748
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD351C215EB
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495F1095C;
	Fri, 14 Jul 2023 10:00:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919FF9FE
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 10:00:04 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55FB1BD4;
	Fri, 14 Jul 2023 02:59:58 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D964B209BD;
	Fri, 14 Jul 2023 11:59:51 +0200 (CEST)
Date: Fri, 14 Jul 2023 11:59:47 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Judith Mendez <jm@ti.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Schuyler Patton <spatton@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v10 0/2] Enable multiple MCAN on AM62x
Message-ID: <ZLEckxW0oLklkMtn@francesco-nb.int.toradex.com>
References: <20230707204714.62964-1-jm@ti.com>
 <20230710-overheat-ruined-12d17707e324-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710-overheat-ruined-12d17707e324-mkl@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Mark,

On Mon, Jul 10, 2023 at 11:57:51AM +0200, Marc Kleine-Budde wrote:
> On 07.07.2023 15:47:12, Judith Mendez wrote:
> > On AM62x there are two MCANs in MCU domain. The MCANs in MCU domain
> > were not enabled since there is no hardware interrupt routed to A53
> > GIC interrupt controller. Therefore A53 Linux cannot be interrupted
> > by MCU MCANs.
...

> Applied to linux-can-next/testing.

Did you forgot to push your changes out? Nothing here
git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git

Francesco


