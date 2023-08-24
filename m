Return-Path: <netdev+bounces-30284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66624786BB3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E471C20DF0
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FDFD524;
	Thu, 24 Aug 2023 09:26:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC299D510
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:26:33 +0000 (UTC)
Received: from anon.cephalopo.net (anon.cephalopo.net [128.76.233.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D769E7F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lagy.org; s=def2;
	t=1692869184; bh=1iGl0oqlmeYe8UVYMDufOg8cMuZFCrsD3b2RXNpODrY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=xXUHRFfTaFSgsf+HfjNZaUYUIvCO64x68MwaERkHqIodjBDy7dfZf0T677ALk/bX8
	 iRnlAzEVZIjAbYjdx+WvH4Xkd3L7szaudeGmtvj6HGHvrnAbUXLyQ9zif0s+AUZkaU
	 UDBxXt87eGmMuA/rD1VVA1S832T1b22scDtwLCuxCJWsIROZxxU6GEsz5kDGz4lM+s
	 6aJ0Z7s8/HpOduNsLtqGj4wt8oE75x+Qj2dU3QX01DengwAr0RTRlPIKqhvVEurK40
	 +bPm6lYBldiGl4RTzfQ1cmD2mnA5je2SgC3IV8lrgEkJq9EAud1mPxbWfUdSFhhlaE
	 Z7SqvvMOjQafA==
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.auth=u1 smtp.mailfrom=me@lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 9533711C00BE;
	Thu, 24 Aug 2023 11:26:24 +0200 (CEST)
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87fs489agk.fsf@lagy.org> <ad71f412-e317-d8d0-5e9d-274fe0e01374@gmail.com>
User-agent: mu4e 1.8.13; emacs 29.1
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: r8169 link up but no traffic, and watchdog error
Date: Thu, 24 Aug 2023 11:22:58 +0200
In-reply-to: <ad71f412-e317-d8d0-5e9d-274fe0e01374@gmail.com>
Message-ID: <87edjsx03e.fsf@lagy.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Thu, Aug 24 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 18.08.2023 13:49, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>
>> On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>>>
>>> There were some fix in r8169 for power management changes recently.
>>> Could you try the latest stable kernel? 6.4.9 ?
>>>
>>
>> I have just upgraded to latest Debian testing kernel (6.4.0-3-amd64 #1 S=
MP
>> PREEMPT_DYNAMIC Debian 6.4.11-1) but it doesn't seem to make much
>> difference. I can trigger the same issue again, and get similar kernel e=
rror
>> as before:
>>
> From the line above it's not clear which kernel version is used. Best tes=
t with a
> self-compiled mainline kernel.
>
> Please test also with the different ASPM L1 states disabled, you can use =
the sysfs
> attributes under /sys/class/net/enp3s0/device/link/ for this.

My BIOS doesn't seem to allow ASPM even though the BIOS option is set to
"Auto" insteadof "Disabled".

~ $ dmesg | grep -i aspm
[    0.118432] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.199782] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.201735] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    0.750649] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    0.771525] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    0.791797] r8169 0000:08:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    0.807683] r8169 0000:09:00.0: can't disable ASPM; OS doesn't have ASPM=
 control

I cannot see any ASPM files in /sys/class/net/enp*s*/device .

-r--r--r-- 1 root root 4096 aug 24 10:31 iflink
-r--r--r-- 1 root root 4096 aug 24 10:32 link_mode
-rw-r--r-- 1 root root 4096 aug 24 10:32 mtu
-r--r--r-- 1 root root 4096 aug 24 10:31 name_assign_type

>
> Best bisect between last known good kernel and latest 6.4 version.
>

