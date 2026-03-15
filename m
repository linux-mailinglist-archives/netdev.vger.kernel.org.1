Return-Path: <netdev+bounces-267979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fWY3EXg6t2mMOQEAu9opvQ
	(envelope-from <netdev+bounces-267979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 00:02:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BAA292EF3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 00:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAE903002B5D
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 23:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4708A282F03;
	Sun, 15 Mar 2026 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+5UxryL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB824E4AF
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773615730; cv=none; b=L7nL5jEGWvjzUnvDOpogHkz5W9qF5fzm/AMjN4swvPzpI3eP7iTIgKXHPBAwTtgg2g5HTc8Cvb2a/2vDFwu7alPgL27F/nY81prH94EmgYCUakI4jpRKRbSGh5kfumDIKVB4eN7wzi1nMXP9CdfcqU8BEeAqjm1ztfXTQRL/UhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773615730; c=relaxed/simple;
	bh=C/3o/e2lhJgvxVln0BO5swKzlkYEr2/ACMFEp5GPq4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxQe3EfPS/sARuXywM/w8nlYnpzfJlhiK4QYvt8Fe6omLP1EGKfk9B3R+I8rXNvWljIHC22btXNVibnVE4JPUnojZEkYCe3L7Y7T8mtmC2Hs+sX2VHGTqPPFSMfM5SK8EzEMjWR8IJVSsOIOXiaZR9uIhno7NUfbkZSYotXZJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+5UxryL; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0c482e069so225175eec.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 16:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773615728; x=1774220528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I3ZmXZrEtzvZ58HsdD/R5EMsWzXDOKwo96IvwktKxlE=;
        b=T+5UxryL8xlFfsJI117C9gUarDm1PgBFbRMnvUknZohr/CRrUGMk/SM3y1xZnq0BwO
         1gaNhZzDDXDRVykSt9b2PM22sD85yYr/y3Y6Uore9vovHROKkRxhRJSJbVvI0s1zPe9B
         vGb1Ss7eSS7DqirESzISSMeFP+xq2xnxy9LVKFxo3csVmPUCFlAOj8qotZvjwBONY8u+
         hXBW/bXa/JyO+tDwfAzJE5WUgrz1GmEwTt5FXBOGDt2tIQFotpbTX77HAZNpW6xnkOZ6
         iC81ypaxUe7HOtcHorRJbo+8PkaNk7nHPA23P94MJiyrcVL1XZhDVjcn41x1iv80+FmD
         dncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773615728; x=1774220528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3ZmXZrEtzvZ58HsdD/R5EMsWzXDOKwo96IvwktKxlE=;
        b=S03dEqto10JJoHuA6YlCmZPDXS+KdEjdcGcW1J4zTHt9zxWOlx4jiGlwO0kRfwnHvK
         QC1wgC5WUvGvvqYuILQwQgrO79ED+IKA2PWYMhA/58Clj/A2cm0LuBCCxqVIZLi9y93V
         /9wDWU1dqBYMEdHE1ZPG8dNa6JLhULgZ6TceABUHwcba2JMRhCnUdCJ4dF2VNopamvWY
         BLwfieTLBGz4TE6VZ8yd1lMH9+qH3wEizutHxmtxdC302WaFvwGZVH69DEXk2Ftsjguo
         Z4MtB3uBSVZ8wqJsuz6q2nu6z4SnWrdNtDJwOLNMLLP8Telr/24rGqH0+Ad7M7x1hjTF
         FNQQ==
X-Gm-Message-State: AOJu0YzAbmRtAFeq1wnPTIw0sK+sWN/KJrAhl4Dfvm/b5WH67UwFM40D
	gPGowL6QmJeEvHQzSU2aHNK0YQtEwfdpKT6sD/IHtLBDT6N9Xgz9EIDuRk6kCA==
X-Gm-Gg: ATEYQzxWqVV7mlfwnoBj/3AsrSR2FCwb5YlqZOMsBH4oPCC0IiQz9WL1+dRizte2hXK
	TSY+XtIWv/J7fT8EgZoGwOMcWkWe4DKw8hlwDbxW6FCVhqSxDkKrawZsTKaZk90/mTeSYFLyM6F
	qdkvzEqLzpXhj7z8dfnMWvRFTeMHt/kuC7Y49OHUo5cSmH1JvgXZ2XLwKZOIij/2cuC0lW6oaC5
	1i5C59Rvg2EpjsVg187mT/r43SFvIHYEXnK9ELAGZw+GO3Lv4MlAFfBdwjvD1+HjvalPTy6zbnT
	7qoUl7BylDNfMWUEXHrzEkDj52rTBPMK1ek3Ykk4ffvH8blXw928fGaVeBwU7+m4LfOPz2jh2WJ
	T20t3qEtuiLwTtKX4ehxkzji8zTqhvp27PizdTOYmAKPMFG9UNoX/crT1kjSpkEwjSodw+7cGce
	DNbkwK/yMQ6dNLKcCmkzTALUTYEfgKnNkiN8G1n5K6AG+kpN8UmvxYHA4aTo+00HkwCe1uObSpb
	Po=
X-Received: by 2002:a05:7300:2389:b0:2b7:24ad:5c54 with SMTP id 5a478bee46e88-2bea5400f2dmr4696684eec.9.1773615727422;
        Sun, 15 Mar 2026 16:02:07 -0700 (PDT)
Received: from localhost (47-147-17-191.lsan.ca.frontiernet.net. [47.147.17.191])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0b1fc876csm6678294eec.29.2026.03.15.16.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 16:02:06 -0700 (PDT)
Date: Sun, 15 Mar 2026 16:02:06 -0700
From: Huan Zhao <ms.huan.zhao@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: r8169: RTL8125B restores default LEDSEL values on Link Up,
 preventing persistent LED configuration
Message-ID: <abc50IhfdLZRYr0_@ser8.localdomain>
References: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
 <b2f4f1e3-f542-4394-93a3-9023b705e676@gmail.com>
 <abbs0Zp-HeOaC_69@ser8.localdomain>
 <67e97f82-1539-4334-8c95-df6b2f01e769@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e97f82-1539-4334-8c95-df6b2f01e769@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267979-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mshuanzhao@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31BAA292EF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 07:06:58PM +0100, Heiner Kallweit wrote:
>On 15.03.2026 18:41, Huan Zhao wrote:
>> You are correct. I apologize for the incorrect analysis in my previous
>> email. Further testing has clarified the actual behavior.
>>
>> Summary of findings after additional testing:
>>
>> 1. The LEDSEL registers do NOT reset on Link Up.
>>
>>    After writing 0x0000 to all LEDSEL registers via BAR0 MMIO and
>>    triggering multiple Link Up/Down cycles, the registers retained
>>    their zero values throughout. The hardware does not restore any
>>    defaults on link state changes.
>>
>> 2. The real problem is CONFIG_LEDS_TRIGGER_NETDEV=m on Arch Linux.
>>
>>    As you clarified, the LED classdev registers successfully without
>>    ledtrig_netdev present — just without a trigger assigned. However,
>>    the link_* sysfs files (link_100, link_2500, etc.) do not appear
>>    until the netdev trigger is explicitly assigned. Without these
>>    files, there is no way to configure the LED modes through the
>>    standard interface.
>>
>>    The workaround is to ensure ledtrig_netdev loads before r8169
>>    via /etc/modules-load.d/.
>
>The netdev trigger module can be loaded also after r8169, and then
>be assigned as trigger.
>
Confirmed. After unloading ledtrig_netdev and reloading it after r8169
was already running, assigning trigger=netdev to the LED classdev
immediately activated hw_control (offloaded=1) and all link_* files
appeared. Load order does not matter.

This means /etc/modules-load.d/ledtrig-netdev.conf is not needed.

>>
>> 3. Persistent LED disable works correctly via the standard interface.
>>
>>    With ledtrig_netdev loaded before r8169, the following sequence
>>    successfully and persistently disables all LEDs:
>>
>>      echo netdev > /sys/class/leds/enp2s0-N::lan/trigger
>
>How is it if you add a small delay here? I'd have check whether
>assigning a trigger is fully synchronous.
>
This is exactly what we observed in testing. When the script runs from
a udev RUN rule (ACTION=="move" on network interface rename), writing
trigger=netdev succeeds but the link_* files are not yet writable
immediately after. They become writable after a variable delay of up
to several seconds.

Our current workaround in the script is to poll link_100 until it
becomes writable:

   echo netdev > "$led/trigger"
   while ! echo 0 > "$led/link_100" 2>/dev/null; do
       sleep 0.1
   done

When the script runs as a systemd oneshot service after network.target,
this polling loop completes in zero iterations — link_* files are
immediately writable at that point.

So the udev timing issue is likely caused by trigger assignment being
asynchronous, as you suspected.

>>      echo 0 > /sys/class/leds/enp2s0-N::lan/link_10
>>      echo 0 > /sys/class/leds/enp2s0-N::lan/link_100
>>      echo 0 > /sys/class/leds/enp2s0-N::lan/link_1000
>>      echo 0 > /sys/class/leds/enp2s0-N::lan/link_2500
>>      echo 0 > /sys/class/leds/enp2s0-N::lan/tx
>>      echo 0 > /sys/class/leds/enp2s0-N::lan/rx
>>
>>    This survives Link Up/Down cycles and network cable
>>    insertion/removal without any further intervention.
>>
>>    This is implemented as a systemd oneshot service running after
>>    network.target, at which point all link_* files are immediately
>>    writable with no waiting required.
>>
>> 4. Remaining question: udev timing issue.
>>
>>    When the same script runs from a udev RUN rule (triggered on
>>    ACTION=="move" for the network interface rename), the link_*
>>    files are not yet writable at that point, even after
>>    trigger=netdev is set. The files only become writable after
>>    a delay of up to several seconds. Is there a reliable udev
>>    event or sysfs condition that indicates hw_control is fully
>>    ready for writing?
>>
>> Thanks,
>> Huan Zhao
>>
>> On Sun, Mar 15, 2026 at 02:55:17PM +0100, Heiner Kallweit wrote:
>>> On 15.03.2026 02:46, Huan Zhao wrote:
>>>> Hardware: Beelink SER8 mini PC
>>>> NIC: Realtek RTL8125B (XID 0x641, RTL_GIGA_MAC_VER_63, rev 05)
>>>> Kernel: 6.19.6-arch1-1
>>>> Driver: r8169 (in-tree)
>>>> CONFIG_R8169_LEDS=y
>>>> CONFIG_LEDS_TRIGGER_NETDEV=m
>>>>
>>>> Problem:
>>>> The RTL8125B chip restores its LEDSEL registers to hardware default values
>>>> on every Link Up event. The r8169 driver does not reapply the LED
>>>> configuration after Link Up, making it impossible to persistently configure
>>>> LEDs (e.g. disable them) through the standard kernel LED subsystem.
>>>>
>>>> Details:
>>>>
>>>> The Link Up path in the driver is:
>>>>
>>>>   r8169_phylink_handler()       [r8169_main.c:4757]
>>>>     -> rtl_link_chg_patch()     [r8169_main.c:1597]
>>>>     -> rtl_enable_tx_lpi()
>>>>     -> pm_request_resume()
>>>>
>>>> rtl_link_chg_patch() has no handling for RTL_GIGA_MAC_VER_63 and does not
>>>> touch the LEDSEL registers. Similarly, rtl_hw_start_8125b() and
>>>> rtl_hw_start_8125_common(), which are called on hardware initialization,
>>>> do not write to any LEDSEL register (LEDSEL0=0x18, LEDSEL1=0x86,
>>>> LEDSEL2=0x84, LEDSEL3=0x96).
>>>>
>>>> The only driver code that writes LEDSEL registers is rtl8125_set_led_mode()
>>>> in r8169_leds.c, called exclusively from the LED classdev hw_control
>>>> callbacks. Therefore, any LED configuration applied via sysfs is silently
>>>> overwritten by the hardware chip's own firmware on every Link Up event,
>>>> before the driver has a chance to reapply it.
>>>>
>>>> This was verified by observing that:
>>>> 1. Writing 0x0000 to all LEDSEL registers (via BAR0 MMIO) before Link Up
>>>>    successfully turns off all LEDs.
>>>> 2. After Link Up completes, the LEDSEL registers revert to their hardware
>>>>    defaults, turning the LEDs back on.
>>>> 3. Writing 0x0000 to LEDSEL registers immediately after Link Up (via
>>>>    NetworkManager dispatcher triggered on dhcp4-change) successfully keeps
>>>>    the LEDs off persistently.
>>>>
>>>> Original LEDSEL register values (hardware defaults) on this machine:
>>>>   LEDSEL0 (0x18) = 0x0002  (LINK_100)
>>>>   LEDSEL1 (0x86) = 0x0028  (LINK_2500 + LINK_1000)
>>>>   LEDSEL2 (0x84) = 0x022b  (ACT + LINK_2500 + LINK_1000 + LINK_100 + LINK_10)
>>>>   LEDSEL3 (0x96) = 0x0020  (LINK_2500)
>>>>
>>>> Secondary issue: CONFIG_LEDS_TRIGGER_NETDEV=m causes silent failure
>>>>
>>>> On Arch Linux, CONFIG_LEDS_TRIGGER_NETDEV=m (module, not built-in).
>>>> The r8169 driver uses /* ignore errors */ when calling
>>>> led_classdev_register() in rtl8125_setup_led_ldev(). If ledtrig_netdev
>>>> is not loaded when r8169 initializes, the registration fails silently.
>>>
>>> No, it doesn't fail. Just that no trigger is assigned by default.
>>> Once you load ledtrig-netdev module and assign netdev trigger to
>>> the LED, you can control LED hw modes.
>>>
>>>
>>>> The result is that /sys/class/leds/enp2s0-* entries appear to exist but
>>>> are dummy stubs with no hardware control capability. Writing to their
>>>> trigger or brightness attributes has no effect on the physical LEDs.
>>>>
>>> Setting brightness manually isn't supported by HW.
>>>
>>>> This was verified by manually loading ledtrig_netdev before r8169, which
>>>> resulted in functional LED classdev entries. The fix was to add
>>>> ledtrig_netdev to /etc/modules-load.d/ to ensure it loads before r8169.
>>>>
>>>> However, even with ledtrig_netdev loaded correctly and offloaded=1
>>>> confirmed, the LED configuration is still lost on every Link Up due to
>>>> the hardware reset described above.
>>>>
>>>> Suggested fix:
>>>>
>>>> In r8169_phylink_handler(), after Link Up is confirmed, reapply the
>>>> current LED configuration by notifying the LED classdevs. For example:
>>>>
>>>>   if (netif_carrier_ok(ndev)) {
>>>>       rtl_link_chg_patch(tp);
>>>>       rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
>>>>       /* Reapply LED configuration after hardware resets LEDSEL on Link Up */
>>>>       if (tp->leds)
>>>>           led_classdev_notify_clients(tp->leds);  /* or equivalent */
>>>>       pm_request_resume(d);
>>>>   }
>>>>
>>>> The exact mechanism for reapplying the LED configuration (whether through
>>>> the LED classdev framework or by directly re-calling rtl8125_set_led_mode()
>>>> with saved values) is left to your discretion.
>>>>
>>>> Thanks,
>>>> Huan Zhao
>>>
>

