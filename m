Return-Path: <netdev+bounces-232077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1487AC00A37
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525BE3AE54A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C7430C345;
	Thu, 23 Oct 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DYxOP7Y9"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514073043CF;
	Thu, 23 Oct 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217779; cv=none; b=N2lK/DASvg2NfFHHgMnKZndkRLav/lfzm/Mjp4o9MiMvyPWLKtqkLjJ/PHYG7jJI2FXdR4iSXKns0R3JnxvB6sBH72sx95dGLwtNxCsKk41zAIXab+h/pJiTOcTdL49D93qmG2wRW2E/zH7Jq3qkw955DcR5rVzAh4pb1wk7F9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217779; c=relaxed/simple;
	bh=whx3qauetCaL8L4L/j6vIJhu8Al6aBGqgPVGr7Y+0y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmJyCq7bIxHGwkBOazi+6830XdQgq1N05z/3NDQ/La+PN31uW9t3oRw3RznBHv2JLy/EWrAzxhTRVYcojdSj2zSbdMLlyVlWLgG2hhz/Y77zUnIHTLXpwGbGhZj+Q4L9gJZsZWAMkVjNasGPL7FMv02e264UgywTq7e4YnDggmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DYxOP7Y9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761217775;
	bh=whx3qauetCaL8L4L/j6vIJhu8Al6aBGqgPVGr7Y+0y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYxOP7Y98ENygjBbGy1cxfywA2ToT7ntiDye2btmfJLFQ9t4f0bh3I+180vRpleYa
	 mBzJRPPPkvd2nnt4SUBL9NSGmlE6hFBiXCEiz1AhStX9y0HFYIiI1YVYoZlu7zxnlR
	 mCXHkxr6maqOiBMlzVGCtQuL18faF0Jd5RSfUdngZTzoBgpc4ghtu7QUhz3xTwtj7j
	 /EEMaHYVzs4gyMvly/5/ae+Y/I08BVIPvtLaZo+xvCnkfqVhWdiGzDcDu67wWIAIXL
	 UXRW4Nyt8UdJFTX2KXOeF5ljn/DHtt1AU+n/EPNMiDMofwzYmnzrbLGpl7VbPZDsVs
	 mrRwaQ4PyG5Sw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:6ab:9c26:3ff9:9bf9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7498817E00B0;
	Thu, 23 Oct 2025 13:09:34 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: frank-w@public-files.de
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	daniel@makrotopia.org,
	devicetree@vger.kernel.org,
	guangjie.song@mediatek.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	netdev@vger.kernel.org,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh@kernel.org,
	sboyd@kernel.org,
	wenst@chromium.org
Subject: Re: issue with [PATCH v6 06/27] clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
Date: Thu, 23 Oct 2025 13:09:22 +0200
Message-Id: <20251023110922.186619-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <trinity-00d61a0e-40f3-449d-814a-eccd621b4665-1760291406778@trinity-msg-rest-gmx-gmx-live-ddd79cd8f-fsr29>
References: <trinity-00d61a0e-40f3-449d-814a-eccd621b4665-1760291406778@trinity-msg-rest-gmx-gmx-live-ddd79cd8f-fsr29>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Frank,

On 10/12/25 19:50, Frank Wunderlich wrote:
> Hi,
>
> this patch seems to break at least the mt7987 device i'm currently working on with torvalds/master + a bunch of some patches for mt7987 support.
>
> if i revert these 2 commits my board works again:
>
> Revert "clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct" => 8ceff24a754a
> Revert "clk: mediatek: clk-gate: Add ops for gates with HW voter"
>
> if i reapply the first one (i had to revert the second before), it is broken again.
>
> I have seen no changes to other clock drivers in mtk-folder. Mt7987 clk driver is not upstream yet, maybe you can help us changing this driver to work again.
>
> this is "my" commit adding the mt7987 clock driver...
>
> https://github.com/frank-w/BPI-Router-Linux/commit/7480615e752dee7ea9e60dfaf31f39580b4bf191
>
> start of trace (had it sometimes with mmc or spi and a bit different with 2p5g phy, but this is maybe different issue):
>
> [    5.593308] Unable to handle kernel paging request at virtual address ffffffc081371f88
> [    5.593322] Mem abort info:
> [    5.593324]   ESR = 0x0000000096000007
> [    5.593326]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    5.593329]   SET = 0, FnV = 0
> [    5.593331]   EA = 0, S1PTW = 0
> [    5.593333]   FSC = 0x07: level 3 translation fault
> [    5.593336] Data abort info:
> [    5.593337]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> [    5.593340]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    5.593343]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    5.593345] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000045294000
> [    5.593349] [ffffffc081371f88] pgd=1000000045a7f003, p4d=1000000045a7f003, pud=1000000045a7f003, pmd=1000000045a82003, pte=0000000000000000
> [    5.593364] Internal error: Oops: 0000000096000007 [#1]  SMP
> [    5.593369] Modules linked in:
> [    5.593375] CPU: 0 UID: 0 PID: 1570 Comm: udevd Not tainted 6.17.0-bpi-r4 #7 NONE 
> [    5.593381] Hardware name: Bananapi BPI-R4-LITE (DT)
> [    5.593385] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    5.593390] pc : mtk_cg_enable+0x14/0x38
> [    5.593404] lr : clk_core_enable+0x70/0x16c
> [    5.593411] sp : ffffffc085853090
> [    5.593413] x29: ffffffc085853090 x28: 0000000000000000 x27: ffffffc0800b82c4
> [    5.593420] x26: ffffffc085853754 x25: 0000000000000004 x24: ffffff80001828f4
> [    5.593426] x23: 0000000000000000 x22: ffffff80030620c0 x21: ffffff8007819580
> [    5.593432] x20: 0000000000000000 x19: ffffff8000feee00 x18: 0000003e39f23000
> [    5.593438] x17: ffffffffffffffff x16: 0000000000020000 x15: ffffff8002f590a0
> [    5.593444] x14: ffffff800346e000 x13: 0000000000000000 x12: 0000000000000000
> [    5.593450] x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000000
> [    5.593455] x8 : ffffffc085853528 x7 : 0000000000000000 x6 : 0000000000002c01
> [    5.593461] x5 : ffffffc080858794 x4 : 0000000000000014 x3 : 0000000000000001
> [    5.593467] x2 : 0000000000000000 x1 : ffffffc081371f70 x0 : ffffff8001028c00
> [    5.593473] Call trace:
> [    5.593476]  mtk_cg_enable+0x14/0x38 (P)
> [    5.593484]  clk_core_enable+0x70/0x16c
> [    5.593490]  clk_enable+0x28/0x54
> [    5.593496]  mtk_spi_runtime_resume+0x84/0x174
> [    5.593506]  pm_generic_runtime_resume+0x2c/0x44
> [    5.593513]  __rpm_callback+0x40/0x228
> [    5.593521]  rpm_callback+0x38/0x80
> [    5.593527]  rpm_resume+0x590/0x774
> [    5.593533]  __pm_runtime_resume+0x5c/0xcc
> [    5.593539]  spi_mem_access_start.isra.0+0x38/0xdc
> [    5.593545]  spi_mem_exec_op+0x40c/0x4e0
>
> it is not clear for me, how to debug further as i have different clock drivers (but i guess either the infracfg is the right).
> maybe the critical-flag is not passed?
>
> regards Frank
>

Could you try adding some debug prints to help identify the specific 
gate/gates causing the issue? It would be very helpful in narrowing 
down the problem.

A couple notes - I noticed that some mux-gate clocks have -1 assigned to 
the _gate, _upd_ofs, and _upd unsigned int fields. Not sure this is 
directly related to the crash above, but it’s something that should 
be addressed regardless:

MUX_GATE_CLR_SET_UPD(CLK_INFRA_MUX_UART0_SEL, "infra_mux_uart0_sel",
		     infra_mux_uart0_parents, 0x0018, 0x0010, 0x0014,
		     0, 1, -1, -1, -1),

I think __initconst should also be removed from clocks that are used at 
runtime. I’m not certain this is directly related to the issue, but I
wanted to mention it in case it’s helpful.

Best,

Laura

>
>> Gesendet: Sonntag, 21. September 2025 um 18:53
>> Von: "Stephen Boyd" <sboyd@kernel.org>
>> An: "Laura Nao" <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
>> CC: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, "Laura Nao" <laura.nao@collabora.com>
>> Betreff: Re: [PATCH v6 06/27] clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
>>
>> Quoting Laura Nao (2025-09-15 08:19:26)
>>> MT8196 uses a HW voter for gate enable/disable control, with
>>> set/clr/sta registers located in a separate regmap. Refactor
>>> mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer to
>>> it in struct mtk_clk_gate. This allows reuse of the static gate data
>>> (including HW voter register offsets) without adding extra function
>>> arguments, and removes redundant duplication in the runtime data struct.
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>> ---
>>
>> Applied to clk-next
>


