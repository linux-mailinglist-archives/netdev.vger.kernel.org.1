Return-Path: <netdev+bounces-25431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D90773F21
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270301C20F52
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774410941;
	Tue,  8 Aug 2023 16:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03041B7F0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:41:45 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D1A3D1A7;
	Tue,  8 Aug 2023 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8W7ui4/ArngIuKAXYPl2b6CpuAAumlmrDpsvogYUsJU=;
	t=1691512888; x=1692722488; b=VqHkCl1ozxULWVA3NeNtibulfF/v8/0ZJ4d8FbBCzmZrndj
	QuU6ZxSQNzyaNHCKkC+9bqzTppTjUs/gA/DTwFH3Chyelyx0Mup2YtSq0NoCJpy247wVeDtbV6YiF
	8pBcVUOHDa3dHVhrxwehEzNJT3/ZeJTSShsvRetlkwDP+t/UTyU/ZO/TeG/psnCwm1DGqrL3BwAJK
	beH/W7GdiIa7r3Tk80xl/aKU1ffWrTF6DlOo+r2u8J4rloxkuUPRP7D+nvjhlnfYMmZYGlmyO2kdx
	Z/KkXLstdRkVZ2L5ncH/6j6kp5Df3wGaa8eehvR8ZR6lxZabqZGBikzlkpxdfOcg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qTI0x-00CQmg-1I;
	Tue, 08 Aug 2023 10:24:27 +0200
Message-ID: <cdf75cdfeb3640e7096940b3f15a8cd86bf5451e.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: mesh: Remove unused function declaration
 mesh_ids_set_default()
From: Johannes Berg <johannes@sipsolutions.net>
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, 
	pagadala.yesu.anjaneyulu@intel.com
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 08 Aug 2023 10:24:26 +0200
In-Reply-To: <20230731140712.1204-1-yuehaibing@huawei.com>
References: <20230731140712.1204-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-31 at 22:07 +0800, Yue Haibing wrote:
> Commit ccf80ddfe492 ("mac80211: mesh function and data structures definit=
ions")
> introducted this but never implemented.
>=20

Btw, are you detecting these with some kind of tool? Having the tool
would probably be more useful than you sending all these patches all the
time ...

johannes

