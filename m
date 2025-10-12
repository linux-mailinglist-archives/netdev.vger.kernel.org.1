Return-Path: <netdev+bounces-228641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B12F2BD08F0
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34A744E877B
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D752ED854;
	Sun, 12 Oct 2025 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="IaPMPn++"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E62820B7;
	Sun, 12 Oct 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760291429; cv=none; b=Wo7jlGMJmCBvn+9/LWpbikomTTc0LQoc+DHcvqiHv5DPmej2rEI8HsHxK/ox00F0l+e18HuOII+xoA8rd7JrO39avTdzUWRjZSuETW1kpr8S9DRMwg8Dd9HE+q2qt2cfZZi3rtiuDfy0I8G1yMmZvRLOC3Z+N2JF/P5Zs7H9Rtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760291429; c=relaxed/simple;
	bh=vbCLmUi3B2V7qwEnQhKS7oxeMALIvVvA99ayprZ78KU=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=BfbYWFtFCUzx+QK1no6uaE8mFBZUwMUpMifxJVSCH5S8XoG/dmoyQkae5oRIoRQWLviaWJfJb1mLKA++KvFuz++lFo3fzb6OgMi9PS0gv+3oK5FL1wMJmZV2BVExjQnK6NZvJxTXJEhnifmw/h3LvUr3kj94eSftgATTT/PorZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=IaPMPn++; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1760291407; x=1760896207; i=frank-w@public-files.de;
	bh=VS5mJuRt7NybCdd4Ecws91UoWs4T7QGiixWFc0dzzRc=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IaPMPn++WJZJ08mzQBXI0kGSkK7sgJc8ROf1jauZimoa9Eg4jOOpsp/Lmm9qawbY
	 W9TX703JALPIUSgXnePDWiR24LvElhkqp1O7uwNwB0DsJVBr8YV73HuZDXfOW7wQh
	 J0ClizucF4UoDg/dfELL+sdxxc4Mxz7gsXQ8kfry4E6u9qgS5NiBaCiRWSQ2fQT0Q
	 y4uBdFWsSaJbs3uBpUnAnJMTCNvfvVxX867f9FuMYXit38+cEWwkb9GJOlK1Sgj1t
	 XIoeIMe0RKBgOfr0+kZDE8KrW4YR8WFqmzqFKO2UmUkBvCdExhr70P5nvc8GBkUL7
	 IcFOCOGW/3wL5d0WPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [194.15.83.249] ([194.15.83.249]) by
 trinity-msg-rest-gmx-gmx-live-ddd79cd8f-fsr29 (via HTTP); Sun, 12 Oct 2025
 17:50:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-00d61a0e-40f3-449d-814a-eccd621b4665-1760291406778@trinity-msg-rest-gmx-gmx-live-ddd79cd8f-fsr29>
From: Frank Wunderlich <frank-w@public-files.de>
To: sboyd@kernel.org, laura.nao@collabora.com, daniel@makrotopia.org
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com, laura.nao@collabora.com,
 angelogioacchino.delregno@collabora.com, conor+dt@kernel.org,
 p.zabel@pengutronix.de, mturquette@baylibre.com, matthias.bgg@gmail.com,
 robh@kernel.org, richardcochran@gmail.com, krzk+dt@kernel.org
Subject: issue with [PATCH v6 06/27] clk: mediatek: clk-gate: Refactor
 mtk_clk_register_gate to use mtk_gate struct
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Oct 2025 17:50:06 +0000
In-Reply-To: <175847361261.4354.11188825521023748179@lazor>
References: <20250915151947.277983-1-laura.nao@collabora.com>
 <20250915151947.277983-7-laura.nao@collabora.com>
 <175847361261.4354.11188825521023748179@lazor>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:6qoFK/ofxxdJIrayycdDRTIkjcKzc0XyvSIzumhwWQq0fQpZw8MOkueUU6UmRwnACfG8z
 ooTCeFLCB8n8T1cRhqse5ZqyzWzoyl6nO3ExWuaLa8a4YfCy5BbT70gVODUlobROJL6ZwsaySakt
 Zt2h4m6XCOloS8LxVWm3lghFbb3OaPxhnchVUODdaDcT7nQOkPeFl7BlocKEJoO5oFizUncgstft
 3AbTS9lw1fik7uNGgztFam/QsJ6kkuG1yQoa5/2y+cUG6fZ891dmqTLsV7LkOxe6Oaya0ok1OA51
 u7eYjE6AzTa63TB6WaQyOGr5hV1jEMSWt57r+9KBbY360Ubszw3JjB96CrzoyJeBOI=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aQygJD0GJNU=;XKkKEjA+wKTP5MBqSmhfsUqSlTe
 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
 D
Content-Transfer-Encoding: quoted-printable

Hi,

this patch seems to break at least the mt7987 device i'm currently working=
 on with torvalds/master + a bunch of some patches for mt7987 support.

if i revert these 2 commits my board works again:

Revert "clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk=
_gate struct" =3D> 8ceff24a754a
Revert "clk: mediatek: clk-gate: Add ops for gates with HW voter"

if i reapply the first one (i had to revert the second before), it is brok=
en again.

I have seen no changes to other clock drivers in mtk-folder. Mt7987 clk dr=
iver is not upstream yet, maybe you can help us changing this driver to wo=
rk again.

this is "my" commit adding the mt7987 clock driver...

https://github.com/frank-w/BPI-Router-Linux/commit/7480615e752dee7ea9e60df=
af31f39580b4bf191

start of trace (had it sometimes with mmc or spi and a bit different with =
2p5g phy, but this is maybe different issue):

[    5.593308] Unable to handle kernel paging request at virtual address f=
fffffc081371f88
[    5.593322] Mem abort info:
[    5.593324]   ESR =3D 0x0000000096000007
[    5.593326]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    5.593329]   SET =3D 0, FnV =3D 0
[    5.593331]   EA =3D 0, S1PTW =3D 0
[    5.593333]   FSC =3D 0x07: level 3 translation fault
[    5.593336] Data abort info:
[    5.593337]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
[    5.593340]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[    5.593343]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[    5.593345] swapper pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000045294=
000
[    5.593349] [ffffffc081371f88] pgd=3D1000000045a7f003, p4d=3D1000000045=
a7f003, pud=3D1000000045a7f003, pmd=3D1000000045a82003, pte=3D000000000000=
0000
[    5.593364] Internal error: Oops: 0000000096000007 [#1]  SMP
[    5.593369] Modules linked in:
[    5.593375] CPU: 0 UID: 0 PID: 1570 Comm: udevd Not tainted 6.17.0-bpi-=
r4 #7 NONE=20
[    5.593381] Hardware name: Bananapi BPI-R4-LITE (DT)
[    5.593385] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    5.593390] pc : mtk_cg_enable+0x14/0x38
[    5.593404] lr : clk_core_enable+0x70/0x16c
[    5.593411] sp : ffffffc085853090
[    5.593413] x29: ffffffc085853090 x28: 0000000000000000 x27: ffffffc080=
0b82c4
[    5.593420] x26: ffffffc085853754 x25: 0000000000000004 x24: ffffff8000=
1828f4
[    5.593426] x23: 0000000000000000 x22: ffffff80030620c0 x21: ffffff8007=
819580
[    5.593432] x20: 0000000000000000 x19: ffffff8000feee00 x18: 0000003e39=
f23000
[    5.593438] x17: ffffffffffffffff x16: 0000000000020000 x15: ffffff8002=
f590a0
[    5.593444] x14: ffffff800346e000 x13: 0000000000000000 x12: 0000000000=
000000
[    5.593450] x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000=
000000
[    5.593455] x8 : ffffffc085853528 x7 : 0000000000000000 x6 : 0000000000=
002c01
[    5.593461] x5 : ffffffc080858794 x4 : 0000000000000014 x3 : 0000000000=
000001
[    5.593467] x2 : 0000000000000000 x1 : ffffffc081371f70 x0 : ffffff8001=
028c00
[    5.593473] Call trace:
[    5.593476]  mtk_cg_enable+0x14/0x38 (P)
[    5.593484]  clk_core_enable+0x70/0x16c
[    5.593490]  clk_enable+0x28/0x54
[    5.593496]  mtk_spi_runtime_resume+0x84/0x174
[    5.593506]  pm_generic_runtime_resume+0x2c/0x44
[    5.593513]  __rpm_callback+0x40/0x228
[    5.593521]  rpm_callback+0x38/0x80
[    5.593527]  rpm_resume+0x590/0x774
[    5.593533]  __pm_runtime_resume+0x5c/0xcc
[    5.593539]  spi_mem_access_start.isra.0+0x38/0xdc
[    5.593545]  spi_mem_exec_op+0x40c/0x4e0

it is not clear for me, how to debug further as i have different clock dri=
vers (but i guess either the infracfg is the right).
maybe the critical-flag is not passed?

regards Frank


> Gesendet: Sonntag, 21. September 2025 um 18:53
> Von: "Stephen Boyd" <sboyd@kernel.org>
> An: "Laura Nao" <laura.nao@collabora.com>, angelogioacchino.delregno@col=
labora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.co=
m, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.c=
om, robh@kernel.org
> CC: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kerne=
l.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm=
-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vg=
er.kernel.org, kernel@collabora.com, "Laura Nao" <laura.nao@collabora.com>
> Betreff: Re: [PATCH v6 06/27] clk: mediatek: clk-gate: Refactor mtk_clk_=
register_gate to use mtk_gate struct
>
> Quoting Laura Nao (2025-09-15 08:19:26)
> > MT8196 uses a HW voter for gate enable/disable control, with
> > set/clr/sta registers located in a separate regmap. Refactor
> > mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer t=
o
> > it in struct mtk_clk_gate. This allows reuse of the static gate data
> > (including HW voter register offsets) without adding extra function
> > arguments, and removes redundant duplication in the runtime data struc=
t.
> >=20
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@col=
labora.com>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Signed-off-by: Laura Nao <laura.nao@collabora.com>
> > ---
>=20
> Applied to clk-next


