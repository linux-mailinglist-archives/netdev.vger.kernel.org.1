Return-Path: <netdev+bounces-232496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E232C06031
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1981891565
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5622316911;
	Fri, 24 Oct 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OaL5RA3S"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FF3128B2;
	Fri, 24 Oct 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304890; cv=none; b=Sv2ICO9bhP354DFJ75wBH2HQdPR11QYz/IXmanud7H7VyT49AKvyc3eP1F6bBRlJ3vOAh05OzpftFEM3DexRz01vqc0jcF99MtbF97S7YIpgiDrIsK4GqiP5KNwXRqTnPRaN0D8whNSvZrHqDofBU9Dq1hKycis4jt1Wf37uxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304890; c=relaxed/simple;
	bh=37d8iZ6sqEgNCnMQCJhbFylmcchhl3vecPg+j3c3j1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRCw2I+byl0AG2r87ElSHwz36fqt2j5nbVsodUx0XFSVI7dEQwQoE3vyUZk++GD76XBiz70tqCS6Ii79ttLO6jJi/GRG23t9tjTrKEN1JJSDOxMgCzmjx2oQ8K7axHeAoHqMHi+DC0LsavOoPa5bIYzr/61zz7m5rHmpVx47Qco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OaL5RA3S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761304886;
	bh=37d8iZ6sqEgNCnMQCJhbFylmcchhl3vecPg+j3c3j1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaL5RA3SomBWR0cnEsTRoIu1XpKPkcua1YrKrcDqDs6fCHrSTWPohY855fOJ+LwNZ
	 7fioYj9BSlnA9NYuiYr0kf8CTI7dyJ5T7KXcVC6zLIJ70b8xeIF3fbENucGzSkKO3i
	 nxwYmZ4EcdJdON/D+5F8m34ta+kdLehc0SsKhSDXi1Pphv+kOSoXxHZGXlN2cCpcFK
	 Fl+YQhmfGAKJdrFEcFw1KchqzD2NyfiTUrVNu28UTacPQp7b6ibP08Zpt4YjpmTKF1
	 0oQLu81OjAmJFy35fDzl33ao9to4QDwpPL8CpahDpxzcpDZWag49CxrAygHxqFUwBZ
	 t7dclKx87+irg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:94aa:26e5:6679:8bb7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F00A317E0CA1;
	Fri, 24 Oct 2025 13:21:24 +0200 (CEST)
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
Date: Fri, 24 Oct 2025 13:21:12 +0200
Message-Id: <20251024112112.720717-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <trinity-47d20d09-1f01-4181-9e9a-b805dd6937a8-1761240870369@trinity-msg-rest-gmx-gmx-live-654c5495b9-fz7pw>
References: <trinity-47d20d09-1f01-4181-9e9a-b805dd6937a8-1761240870369@trinity-msg-rest-gmx-gmx-live-654c5495b9-fz7pw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Frank,

On 10/23/25 19:34, frank-w@public-files.de wrote:
> Hi Laura
>
> thanks for first look
>
> tried to replace the -1 values in infracfg driver with 0, but then it's getting worse (debug uart issues came on top and still the "Unable to handle kernel paging request" for on mmc driver while enabling the clock gate - msdc_gate_clock).
>

If _gate is not defined, these appear to be mux clocks rather than 
mux-gates. In that case, they should be defined accordingly - I believe 
MUX_CLR_SET_UPD would be appropriate here?

> i wonder why msdc_gate_clock disables the clocks and msdc_ungate_clock enables them...but in mmc driver first ungate is called which failes and then 
>
> mmc itself seems to be probed already, maybe switch to uhs triggers this
>
> [    3.659479] mtk-msdc 11230000.mmc: Got CD GPIO
> [    3.698999] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=52 arg=00000C00; host->error=0x00000002
> [    3.708205] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=52 arg=80000C08; host->error=0x00000002
> [    3.727275] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=5 arg=00000000; host->error=0x00000002
> [    3.736355] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=5 arg=00000000; host->error=0x00000002
> [    3.745425] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=5 arg=00000000; host->error=0x00000002
> [    3.754505] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=5 arg=00000000; host->error=0x00000002
>
> [    3.796499] mmc0: host does not support reading read-only switch, assuming write-enable
> [    3.810131] mmc0: new high speed SDHC card at address aaaa
> [    3.817725] mmcblk0: mmc0:aaaa SC32G 29.7 GiB
> [    3.837920]  mmcblk0: p1 p2 p3 p4 p5 p6
>
> the msdc_track_cmd_data errors already appearing on other boards since this error is printed at early boottime (not later) by a recent commit, so i guess this is unrelated.
>
> the other code position where msdc_gate_clock is called it in msdc_runtime_suspend which seems to be called on first access to mmc while
> bootup (mount rootfs + starting init), not sure why...
>
> which debugging do you want? tried adding debug in mtk_cg_enable / mtk_cg_disable and it is running through console...stopped that after 2 minutes.
>
> and yes, the -1 cause very high "bit" through BIT(cg->gate->shift), but set this to 0 seems not fixing it
>
> so i tried debugging it from the msdc driver
>
> [    6.023214] systemd[1]: Hostname set to <bpi-r4-lite>. # first access to sdcard (read from /etc/hostname)
> [    6.117320] mtk-msdc 11230000.mmc: msdc_runtime_suspend:3308 before gate_clock
> [    6.124547] mtk-msdc 11230000.mmc: msdc_gate_clock:925 before bulk_disable_unprepare
> [    6.132296] Unable to handle kernel paging request at virtual address ffffffc0813d2388
> ...
> [    6.235005] pc : mtk_cg_disable+0x18/0x38
> [    6.239009] lr : clk_core_disable+0x7c/0x150
> [    6.243271] sp : ffffffc083a6bbc0
> [    6.246573] x29: ffffffc083a6bbc0 x28: ffffff80012f2180 x27: 0000000000000000
> [    6.253698] x26: ffffff80012f21c0 x25: 00000000000f4240 x24: ffffff80001a1ac0
> [    6.260823] x23: 0000000000000008 x22: 0000000000000004 x21: ffffff80014c4738
> [    6.267947] x20: ffffff800134e600 x19: ffffff800134e600 x18: 00000000ffffffff
> [    6.275072] x17: 755f656c62617369 x16: 645f6b6c75622065 x15: 726f666562203532
> [    6.282197] x14: 00000000ffffffea x13: ffffffc083a6b918 x12: ffffffc081869cf0
> [    6.289321] x11: 0000000000000001 x10: 0000000000000001 x9 : 0000000000017fe8
> [    6.296446] x8 : c0000000ffffefff x7 : ffffffc081811c70 x6 : 0000000000057fa8
> [    6.303570] x5 : ffffffc081869c98 x4 : ffffffc081ace6a8 x3 : 0000000000000001
> [    6.310695] x2 : 0000000000000001 x1 : ffffffc0813d2370 x0 : ffffff8001376800
> [    6.317820] Call trace:
> [    6.320256]  mtk_cg_disable+0x18/0x38 (P)
> [    6.324258]  clk_core_disable+0x7c/0x150
> [    6.328172]  clk_disable+0x30/0x4c
> [    6.331566]  clk_bulk_disable+0x3c/0x58
> [    6.335392]  msdc_gate_clock+0x48/0x15c
> [    6.339220]  msdc_runtime_suspend+0x2a0/0x2e4
>
> result is same with 0 instead of -1, but uart is than scrambled...tried also with changing only spi0/2 to 0 from -1 (sdmmc is connected to spi2 pins),
> but has same effect.
>
> so than i tried removng the __initconst in infracfg clocks and this seems fixing the issue...wonder why this came up with your patch, imho this
> should also happen before.
>

I think that actually makes sense - before the patch, the fields from 
struct mtk_gate were copied into mtk_clk_gate, so it didn’t matter if 
the original data was freed. After the refactoring we store a pointer, 
so once those sections are released, any runtime clock enable ends up 
using a dangling pointer.

As those clocks seems to be used during runtime, removing __initconst
seems like the right thing to do. Those mux-gates that lack a gate 
should be turned into plain muxes anyway though.

Best,

Laura

> only noticed with my debugs, that sdmmc does the
> gate_clock/ungate_clock nearly every second...not sure if this is normal as we normally do not see it.
>
> regards Frank
>
>> Gesendet: Donnerstag, 23. Oktober 2025 um 13:09
>> Von: "Laura Nao" <laura.nao@collabora.com>
>> An: frank-w@public-files.de
>> CC: angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, daniel@makrotopia.org, devicetree@vger.kernel.org, guangjie.song@mediatek.com, kernel@collabora.com, krzk+dt@kernel.org, laura.nao@collabora.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, mturquette@baylibre.com, netdev@vger.kernel.org, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org, sboyd@kernel.org, wenst@chromium.org
>> Betreff: Re: issue with [PATCH v6 06/27] clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
>>
>> Hi Frank,
>>
>> On 10/12/25 19:50, Frank Wunderlich wrote:
>>> Hi,
>>>
>>> this patch seems to break at least the mt7987 device i'm currently working on with torvalds/master + a bunch of some patches for mt7987 support.
>>>
>>> if i revert these 2 commits my board works again:
>>>
>>> Revert "clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct" => 8ceff24a754a
>>> Revert "clk: mediatek: clk-gate: Add ops for gates with HW voter"
>>>
>>> if i reapply the first one (i had to revert the second before), it is broken again.
>>>
>>> I have seen no changes to other clock drivers in mtk-folder. Mt7987 clk driver is not upstream yet, maybe you can help us changing this driver to work again.
>>>
>>> this is "my" commit adding the mt7987 clock driver...
>>>
>>> https://github.com/frank-w/BPI-Router-Linux/commit/7480615e752dee7ea9e60dfaf31f39580b4bf191
>>>
>>> start of trace (had it sometimes with mmc or spi and a bit different with 2p5g phy, but this is maybe different issue):
>>>
>>> [    5.593308] Unable to handle kernel paging request at virtual address ffffffc081371f88
>>> [    5.593322] Mem abort info:
>>> [    5.593324]   ESR = 0x0000000096000007
>>> [    5.593326]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [    5.593329]   SET = 0, FnV = 0
>>> [    5.593331]   EA = 0, S1PTW = 0
>>> [    5.593333]   FSC = 0x07: level 3 translation fault
>>> [    5.593336] Data abort info:
>>> [    5.593337]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
>>> [    5.593340]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>> [    5.593343]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [    5.593345] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000045294000
>>> [    5.593349] [ffffffc081371f88] pgd=1000000045a7f003, p4d=1000000045a7f003, pud=1000000045a7f003, pmd=1000000045a82003, pte=0000000000000000
>>> [    5.593364] Internal error: Oops: 0000000096000007 [#1]  SMP
>>> [    5.593369] Modules linked in:
>>> [    5.593375] CPU: 0 UID: 0 PID: 1570 Comm: udevd Not tainted 6.17.0-bpi-r4 #7 NONE 
>>> [    5.593381] Hardware name: Bananapi BPI-R4-LITE (DT)
>>> [    5.593385] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [    5.593390] pc : mtk_cg_enable+0x14/0x38
>>> [    5.593404] lr : clk_core_enable+0x70/0x16c
>>> [    5.593411] sp : ffffffc085853090
>>> [    5.593413] x29: ffffffc085853090 x28: 0000000000000000 x27: ffffffc0800b82c4
>>> [    5.593420] x26: ffffffc085853754 x25: 0000000000000004 x24: ffffff80001828f4
>>> [    5.593426] x23: 0000000000000000 x22: ffffff80030620c0 x21: ffffff8007819580
>>> [    5.593432] x20: 0000000000000000 x19: ffffff8000feee00 x18: 0000003e39f23000
>>> [    5.593438] x17: ffffffffffffffff x16: 0000000000020000 x15: ffffff8002f590a0
>>> [    5.593444] x14: ffffff800346e000 x13: 0000000000000000 x12: 0000000000000000
>>> [    5.593450] x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000000
>>> [    5.593455] x8 : ffffffc085853528 x7 : 0000000000000000 x6 : 0000000000002c01
>>> [    5.593461] x5 : ffffffc080858794 x4 : 0000000000000014 x3 : 0000000000000001
>>> [    5.593467] x2 : 0000000000000000 x1 : ffffffc081371f70 x0 : ffffff8001028c00
>>> [    5.593473] Call trace:
>>> [    5.593476]  mtk_cg_enable+0x14/0x38 (P)
>>> [    5.593484]  clk_core_enable+0x70/0x16c
>>> [    5.593490]  clk_enable+0x28/0x54
>>> [    5.593496]  mtk_spi_runtime_resume+0x84/0x174
>>> [    5.593506]  pm_generic_runtime_resume+0x2c/0x44
>>> [    5.593513]  __rpm_callback+0x40/0x228
>>> [    5.593521]  rpm_callback+0x38/0x80
>>> [    5.593527]  rpm_resume+0x590/0x774
>>> [    5.593533]  __pm_runtime_resume+0x5c/0xcc
>>> [    5.593539]  spi_mem_access_start.isra.0+0x38/0xdc
>>> [    5.593545]  spi_mem_exec_op+0x40c/0x4e0
>>>
>>> it is not clear for me, how to debug further as i have different clock drivers (but i guess either the infracfg is the right).
>>> maybe the critical-flag is not passed?
>>>
>>> regards Frank
>>>
>>
>> Could you try adding some debug prints to help identify the specific 
>> gate/gates causing the issue? It would be very helpful in narrowing 
>> down the problem.
>>
>> A couple notes - I noticed that some mux-gate clocks have -1 assigned to 
>> the _gate, _upd_ofs, and _upd unsigned int fields. Not sure this is 
>> directly related to the crash above, but it’s something that should 
>> be addressed regardless:
>>
>> MUX_GATE_CLR_SET_UPD(CLK_INFRA_MUX_UART0_SEL, "infra_mux_uart0_sel",
>> 		     infra_mux_uart0_parents, 0x0018, 0x0010, 0x0014,
>> 		     0, 1, -1, -1, -1),
>>
>> I think __initconst should also be removed from clocks that are used at 
>> runtime. I’m not certain this is directly related to the issue, but I
>> wanted to mention it in case it’s helpful.
>>
>> Best,
>>
>> Laura
>>
>>>
>>>> Gesendet: Sonntag, 21. September 2025 um 18:53
>>>> Von: "Stephen Boyd" <sboyd@kernel.org>
>>>> An: "Laura Nao" <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
>>>> CC: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, "Laura Nao" <laura.nao@collabora.com>
>>>> Betreff: Re: [PATCH v6 06/27] clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct
>>>>
>>>> Quoting Laura Nao (2025-09-15 08:19:26)
>>>>> MT8196 uses a HW voter for gate enable/disable control, with
>>>>> set/clr/sta registers located in a separate regmap. Refactor
>>>>> mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer to
>>>>> it in struct mtk_clk_gate. This allows reuse of the static gate data
>>>>> (including HW voter register offsets) without adding extra function
>>>>> arguments, and removes redundant duplication in the runtime data struct.
>>>>>
>>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>>>> ---
>>>>
>>>> Applied to clk-next
>>>
>>
>>


