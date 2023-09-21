Return-Path: <netdev+bounces-35428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCA7A976D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5A1C20E98
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5F171D1;
	Thu, 21 Sep 2023 17:05:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F238171A4
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:05:38 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863C7693;
	Thu, 21 Sep 2023 10:05:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rrqvj0M5wz4xPc;
	Thu, 21 Sep 2023 19:33:21 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: alsa-devel@alsa-project.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org
In-Reply-To: <20230907095521.14053-1-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
Subject: Re: [PATCH 00/11] add missing of_node_put
Message-Id: <169528860030.876432.17353767421208248949.b4-ty@ellerman.id.au>
Date: Thu, 21 Sep 2023 19:30:00 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 07 Sep 2023 11:55:10 +0200, Julia Lawall wrote:
> Add of_node_put on a break out of an of_node loop.
> 

Patches 3 and 6 applied to powerpc/next.

[03/11] powerpc/powermac: add missing of_node_put
        https://git.kernel.org/powerpc/c/a59e9eb25216eb1dc99e14fc31b76aa648d79540
[06/11] powerpc/kexec_file: add missing of_node_put
        https://git.kernel.org/powerpc/c/06b627c1236216ac1239c5e1afcc75359af3fb72

cheers

