Return-Path: <netdev+bounces-267946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHYxEDnvtmnnKgEAu9opvQ
	(envelope-from <netdev+bounces-267946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:41:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDD4291CED
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A960A300B981
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D637475D;
	Sun, 15 Mar 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kviApVLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AE372EE4
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773596469; cv=none; b=UY6iZu1SAfZmx39uytq+27mLBWlpELOwLllQkwTujthlZQYq7eLzzkfoSHtLeHQG/ez3071SYUvmLk/BaKgA6BerMyn39+YyTDGUoKnRGqaeIMxDyn1EqTgXmMdyblezNNp+vUm+EVHDswp06WrmFgt+eTNkgogrWuK8TNnLnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773596469; c=relaxed/simple;
	bh=J1aGPOtjmwshGP+B3pSMPCpTcqG6voI6anyfoC3Ulu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu4qdro+chb/uEd00GWJ+nMwyskJ3zz2aDsg8M96WXWPOtM/+LXHvur5rqRgK+IJfX2P0RUO8moWeErAFN2GNbeLnlitgTggvFG0WWveWxKWxAlJejeLKN6j7bRXK4CYvTaBoRedK2jU96hEezrBFmiH5yiIqBfa4TYaTAY2K5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kviApVLH; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732165d1eso4755838c88.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773596467; x=1774201267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WjK3QHy60l9POFZfDOCUMIkehynO4JEgZHEphlzdavY=;
        b=kviApVLHJqJTT7kZTOpyyx5rPx6UBgQLYJobRbAVcGeS+x+e+NjG1mgRwomfaitxTC
         muGzntvjp6E94u1fq/Q3g/NwojM4zH13FcW5yzcGxTXftE36x3YYY/LA9w/87TERB73q
         APm1w7ejTgFk4INTSfHnjBVkP+FXgkD0Fq+sXUimvMpFNQeMTn/B8C1MvBkY9F1zMpU/
         +I6CP/ep6ynfSQLxVrhnY5VOLS/IuUn5BtNkjk1o0G52YltV30SsyMxkJcKKoIfQiJn/
         87NReoHTVaqtAFjOQt48TPJR/cNDnZ0xpNq42BaSmsNPN41RvcT++QxHo05lde9hFC6P
         Ik5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773596467; x=1774201267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjK3QHy60l9POFZfDOCUMIkehynO4JEgZHEphlzdavY=;
        b=AdTVnDVU7Z4JCgHND5z/3x7h1TIwv5MrDanRGTs4dXNmY77hIEJvm6EerMqQUMN93/
         kNp5itlmPOXXZ9Wu2uaxNKlJ49MpuQXv2uFizkFzyn/iXj3JbSgSN4I9s/qr39rzgrZv
         10+ZZyUwR65eHNcSl0+Cssh+A/6qLeC9/NGrLh6WKR3dmWXg1c6oXgMauG20a7XnL0cB
         IHMg7XfXYUFCvgT9Ka9G5fXknKnrFHBiXrTZhfcwEexhKAEMf4zpMRHsoMZ7ZO14eBGQ
         Np6OsQP7wgua/Y1doQzuk/WRZBBlOVpr1cUuGrshndZdBGWFGirPwMu6YjV4VJ+RT4f1
         +gmg==
X-Gm-Message-State: AOJu0YztMLozVGufek3yJQiODCaXhFNJMNBa1CP6yN5wIa53/yyOShxk
	MIYrybo4kBeGDShU30St04AKJ72OsnEiGKrfwJSK7lTNfmJYZ5MgbIPpkQ/3FQ==
X-Gm-Gg: ATEYQzyRgSnmitmxFRw1Uh8fi8tnR7Ej6RHmRr04fOoEtyml+0uRH6yrV6qJ7XpO3qz
	cid39cep/tU7swxsRCFEnIq14vgjP15Ljq6mwb/aYfC51TiG/xM0KMSYAMwrudn7nKNMplcqdR+
	LBHdblYmssn7RfflTxcNRcfL9vat0F0QeYslhX3zSalhPXt6TzJaU8Stx1uqWKqi7m3L8isWeAc
	+E2EEuBKD9xY2rqD7VzKZo5SB/izmQbHGJ3a7I5OPgEMpMSU6Zupwpo0ktG44QQKeZlqay+utsM
	UpiuOKp6xFsg0P2L4PBC+n7QHZny3Dw2tnu9D/LsOAGoGsxlUiV2aXB6yI6Xei6S1fEjDUTkh4M
	LEBUvV8UYn7jJGVSKFfJMzEmNMguUe936DP2fxOmM1s86PBWuC5asdM4rhkaDopTrcvbBOZ8H+A
	ql4sUpowBbvXwEy9d4exepTZtuCN7z9C8auwLY1KQTwI40VV8Rp+GLURFv1v+hbSR3
X-Received: by 2002:a05:7022:4185:b0:128:d9a1:b68b with SMTP id a92af1059eb24-128f3dd34bcmr4700909c88.33.1773596466976;
        Sun, 15 Mar 2026 10:41:06 -0700 (PDT)
Received: from localhost (47-147-17-191.lsan.ca.frontiernet.net. [47.147.17.191])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0c6921055sm570853eec.6.2026.03.15.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:41:06 -0700 (PDT)
Date: Sun, 15 Mar 2026 10:41:05 -0700
From: Huan Zhao <ms.huan.zhao@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: r8169: RTL8125B restores default LEDSEL values on Link Up,
 preventing persistent LED configuration
Message-ID: <abbs0Zp-HeOaC_69@ser8.localdomain>
References: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
 <b2f4f1e3-f542-4394-93a3-9023b705e676@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2f4f1e3-f542-4394-93a3-9023b705e676@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267946-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ser8.localdomain:mid]
X-Rspamd-Queue-Id: ABDD4291CED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

You are correct. I apologize for the incorrect analysis in my previous
email. Further testing has clarified the actual behavior.

Summary of findings after additional testing:

1. The LEDSEL registers do NOT reset on Link Up.

    After writing 0x0000 to all LEDSEL registers via BAR0 MMIO and
    triggering multiple Link Up/Down cycles, the registers retained
    their zero values throughout. The hardware does not restore any
    defaults on link state changes.

2. The real problem is CONFIG_LEDS_TRIGGER_NETDEV=m on Arch Linux.

    As you clarified, the LED classdev registers successfully without
    ledtrig_netdev present — just without a trigger assigned. However,
    the link_* sysfs files (link_100, link_2500, etc.) do not appear
    until the netdev trigger is explicitly assigned. Without these
    files, there is no way to configure the LED modes through the
    standard interface.

    The workaround is to ensure ledtrig_netdev loads before r8169
    via /etc/modules-load.d/.

3. Persistent LED disable works correctly via the standard interface.

    With ledtrig_netdev loaded before r8169, the following sequence
    successfully and persistently disables all LEDs:

      echo netdev > /sys/class/leds/enp2s0-N::lan/trigger
      echo 0 > /sys/class/leds/enp2s0-N::lan/link_10
      echo 0 > /sys/class/leds/enp2s0-N::lan/link_100
      echo 0 > /sys/class/leds/enp2s0-N::lan/link_1000
      echo 0 > /sys/class/leds/enp2s0-N::lan/link_2500
      echo 0 > /sys/class/leds/enp2s0-N::lan/tx
      echo 0 > /sys/class/leds/enp2s0-N::lan/rx

    This survives Link Up/Down cycles and network cable
    insertion/removal without any further intervention.

    This is implemented as a systemd oneshot service running after
    network.target, at which point all link_* files are immediately
    writable with no waiting required.

4. Remaining question: udev timing issue.

    When the same script runs from a udev RUN rule (triggered on
    ACTION=="move" for the network interface rename), the link_*
    files are not yet writable at that point, even after
    trigger=netdev is set. The files only become writable after
    a delay of up to several seconds. Is there a reliable udev
    event or sysfs condition that indicates hw_control is fully
    ready for writing?

Thanks,
Huan Zhao

On Sun, Mar 15, 2026 at 02:55:17PM +0100, Heiner Kallweit wrote:
>On 15.03.2026 02:46, Huan Zhao wrote:
>> Hardware: Beelink SER8 mini PC
>> NIC: Realtek RTL8125B (XID 0x641, RTL_GIGA_MAC_VER_63, rev 05)
>> Kernel: 6.19.6-arch1-1
>> Driver: r8169 (in-tree)
>> CONFIG_R8169_LEDS=y
>> CONFIG_LEDS_TRIGGER_NETDEV=m
>>
>> Problem:
>> The RTL8125B chip restores its LEDSEL registers to hardware default values
>> on every Link Up event. The r8169 driver does not reapply the LED
>> configuration after Link Up, making it impossible to persistently configure
>> LEDs (e.g. disable them) through the standard kernel LED subsystem.
>>
>> Details:
>>
>> The Link Up path in the driver is:
>>
>>   r8169_phylink_handler()       [r8169_main.c:4757]
>>     -> rtl_link_chg_patch()     [r8169_main.c:1597]
>>     -> rtl_enable_tx_lpi()
>>     -> pm_request_resume()
>>
>> rtl_link_chg_patch() has no handling for RTL_GIGA_MAC_VER_63 and does not
>> touch the LEDSEL registers. Similarly, rtl_hw_start_8125b() and
>> rtl_hw_start_8125_common(), which are called on hardware initialization,
>> do not write to any LEDSEL register (LEDSEL0=0x18, LEDSEL1=0x86,
>> LEDSEL2=0x84, LEDSEL3=0x96).
>>
>> The only driver code that writes LEDSEL registers is rtl8125_set_led_mode()
>> in r8169_leds.c, called exclusively from the LED classdev hw_control
>> callbacks. Therefore, any LED configuration applied via sysfs is silently
>> overwritten by the hardware chip's own firmware on every Link Up event,
>> before the driver has a chance to reapply it.
>>
>> This was verified by observing that:
>> 1. Writing 0x0000 to all LEDSEL registers (via BAR0 MMIO) before Link Up
>>    successfully turns off all LEDs.
>> 2. After Link Up completes, the LEDSEL registers revert to their hardware
>>    defaults, turning the LEDs back on.
>> 3. Writing 0x0000 to LEDSEL registers immediately after Link Up (via
>>    NetworkManager dispatcher triggered on dhcp4-change) successfully keeps
>>    the LEDs off persistently.
>>
>> Original LEDSEL register values (hardware defaults) on this machine:
>>   LEDSEL0 (0x18) = 0x0002  (LINK_100)
>>   LEDSEL1 (0x86) = 0x0028  (LINK_2500 + LINK_1000)
>>   LEDSEL2 (0x84) = 0x022b  (ACT + LINK_2500 + LINK_1000 + LINK_100 + LINK_10)
>>   LEDSEL3 (0x96) = 0x0020  (LINK_2500)
>>
>> Secondary issue: CONFIG_LEDS_TRIGGER_NETDEV=m causes silent failure
>>
>> On Arch Linux, CONFIG_LEDS_TRIGGER_NETDEV=m (module, not built-in).
>> The r8169 driver uses /* ignore errors */ when calling
>> led_classdev_register() in rtl8125_setup_led_ldev(). If ledtrig_netdev
>> is not loaded when r8169 initializes, the registration fails silently.
>
>No, it doesn't fail. Just that no trigger is assigned by default.
>Once you load ledtrig-netdev module and assign netdev trigger to
>the LED, you can control LED hw modes.
>
>
>> The result is that /sys/class/leds/enp2s0-* entries appear to exist but
>> are dummy stubs with no hardware control capability. Writing to their
>> trigger or brightness attributes has no effect on the physical LEDs.
>>
>Setting brightness manually isn't supported by HW.
>
>> This was verified by manually loading ledtrig_netdev before r8169, which
>> resulted in functional LED classdev entries. The fix was to add
>> ledtrig_netdev to /etc/modules-load.d/ to ensure it loads before r8169.
>>
>> However, even with ledtrig_netdev loaded correctly and offloaded=1
>> confirmed, the LED configuration is still lost on every Link Up due to
>> the hardware reset described above.
>>
>> Suggested fix:
>>
>> In r8169_phylink_handler(), after Link Up is confirmed, reapply the
>> current LED configuration by notifying the LED classdevs. For example:
>>
>>   if (netif_carrier_ok(ndev)) {
>>       rtl_link_chg_patch(tp);
>>       rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
>>       /* Reapply LED configuration after hardware resets LEDSEL on Link Up */
>>       if (tp->leds)
>>           led_classdev_notify_clients(tp->leds);  /* or equivalent */
>>       pm_request_resume(d);
>>   }
>>
>> The exact mechanism for reapplying the LED configuration (whether through
>> the LED classdev framework or by directly re-calling rtl8125_set_led_mode()
>> with saved values) is left to your discretion.
>>
>> Thanks,
>> Huan Zhao
>

