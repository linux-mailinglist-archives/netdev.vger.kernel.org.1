Return-Path: <netdev+bounces-264054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO+PJXOpqGl6wQAAu9opvQ
	(envelope-from <netdev+bounces-264054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:51:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA520835B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F0230137A0
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934A38642F;
	Wed,  4 Mar 2026 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Q60qrm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD4377EA6
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661092; cv=none; b=rcWSZztOH8y/i2c2DQHzmTVcX03CltldfBvWSpXRn5V/hkSxXkdOfCq1Imp9Yf0Fl21y0ZT4mfwNWH9aw7MoBEgKDEErf12LueWqnkmuUALVGQP0glBMe51gm/MZOq14HTAiTGjt91X+QRa0+ZWTaCvwb+OMdtHJsaweClT/3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661092; c=relaxed/simple;
	bh=CsP8pTjB9QN/u3/OgJmn/hGKEmASuttgxpjbBspJClo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxAM73vy+4SSnT8n3xi7DSeIyrxuBHJR+l0tgXBwrxAc3+F7zX22V7p4Qp5GNAMlUeMpYi4rX/juL6+ou33B4egA/qiX6bcGtQfGXEjRt5gs1kccJrOGJlL2rjGOZIPUfZioj61PsbmVH4sAcHjVynMC4+/03VZdr2YQEA+jb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2Q60qrm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so83499125e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 13:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772661089; x=1773265889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eMr6Gc3ayMCoBbsRBgBha/Mlatkmb0RbXBF2t6Pc2Q=;
        b=M2Q60qrmA4f//oxk8GYM69qRFosXWgU9+PbTCRYji/ve7kN5zjPPd61t+n0H6Z8KXw
         JTlV8HX9PxQYgIEp/2JIkjwGOjeJDqOUJ8bjhUTrEN5iXtugiorWFDWXFcEFVRcizsw7
         vTav6UTYuxzL9j+E2cmo9A/OGrSpsThTQAxrkKoytew6BK4nSAbcLxvdsUICnm/n5qn4
         +Qf/zav1kteJROPHy7y2K+OqBQOE5i0Jk9gMXTg6Qb6MTaiQrvg7I0XBUZjs19uBQQNS
         xxpPQ0PJ25Iz24XP70ZuQ1z+9EoPifm2O7ZB8H0UT7xDTya70NiyhgG6tkzfKkUMPNCi
         cZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772661089; x=1773265889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eMr6Gc3ayMCoBbsRBgBha/Mlatkmb0RbXBF2t6Pc2Q=;
        b=TENi+lUT8oSNss0Mg4VHrJf1e2nAnWawfzqhDS280PjGXccUoUiFFrSbYiMU+a7Ae1
         8FuwNfLMnHb7Jsxf3lQKeazNXz+HpZZAJN+lcw1O3cnNsnWy5niwl5zWXXaABOIZJr9u
         9+SCV+XeDEa9MPVdioW0teuZLJEUBmcfa6M5JROviRwpZTEb1aSLsykCbQTnkQn3RNN1
         JMAwIQU8wUbPir1vbTJ0l1ZlJjBhReIMW93vHvI72sqi0WevGfZ6OB6Ztykh55qREpGC
         lkTlp2Cl9xIGKGGAmiuVgFJgYYguwH0KB4ipSgpPAUL5ql+SlDA6oFERtShyQntUKazw
         gjeA==
X-Gm-Message-State: AOJu0YximRWnqWuHMZJI8tCxR9FsUqNmEopmTtqb0+kQLyp4kd3zgFt+
	XWo9j+75O7FjF2CSgi873hEuVN7S17/MLXOtCcQ8umI8xtEN2laBmMVg
X-Gm-Gg: ATEYQzzYY4MarosCNNZqIvI01MDnw2ecdnybaJJeIT4b0voJXh8OrsAZS60R3UuS5/6
	sjwJPBWoaSzmgYFG1FSzbwQtSv+FLq5+TP7o+nZWHjF4OeSdmTosaPtaSgH9ymVkTaETt2fhuYW
	3TYW1pD2+qEc7PR3oEvRt9b20n2GiylLl8kN44Ii/zrejoyHo2Gem+Y16Ienx3MnmVmoNzuD2tC
	tzBmDHy5StQgcR0CNzHj0zwtSlnczYjSVaxXb88DX0EWzOgffbM2rt/+ksuSI297jVKpVlqcq5N
	8s4WxE+G3sI7WSmW5NrDjvPiQAiu+cSzM+eFyt6P9lSI7T0PY/oXQ7Ydbb8Q9T98+o64kMV+g2X
	X+zdtCqvaIMwj8XvHLFsMFh3HDMwldRvnl5es+d8w+2pjhA0cJ+vbUxoiJ28dBPYlV/zEiLA3Me
	Q2bksbT5D7Sf5vT+zl3iYedQHJtIZvvnVmQQCBoI9lHgMVW5QbTqVbVsZL4SJAhLQAWAU4W2BAV
	PPzr4ZMzULq1kbYAJYU8Ok7uwMhLCRMPu3KY5rCzCGsOdFAgyWCQ4gGFOIgwtmsFw==
X-Received: by 2002:a05:600c:8b67:b0:483:afbb:a086 with SMTP id 5b1f17b1804b1-4851989c82emr59392715e9.29.1772661088462;
        Wed, 04 Mar 2026 13:51:28 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:5c00:3037:1150:282e:5094? (p200300ea8f245c0030371150282e5094.dip0.t-ipconnect.de. [2003:ea:8f24:5c00:3037:1150:282e:5094])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a82dac3sm47682785e9.0.2026.03.04.13.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 13:51:26 -0800 (PST)
Message-ID: <33d351be-8a91-4940-950a-7f0866d0cae9@gmail.com>
Date: Wed, 4 Mar 2026 22:51:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 4/4] r8169: enable system enter c10 with
 RTL8116af
To: =?UTF-8?B?6K645L+K5Lyf?= <javen_xu@realsil.com.cn>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260302063215.1790-1-javen_xu@realsil.com.cn>
 <20260302063215.1790-5-javen_xu@realsil.com.cn>
 <9b6aeead-4e60-4df4-8aaf-b07ab2c99d46@gmail.com>
 <f1912e8588604b9b86646a86eac05c6c@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <f1912e8588604b9b86646a86eac05c6c@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0AA520835B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264054-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 04.03.2026 10:43, 许俊伟 wrote:
>> On 02.03.2026 07:32, javen wrote:
>>> From: Javen Xu <javen_xu@realsil.com.cn>
>>>
>>> RTL8116af is a multi function chip. Function 1 is load with r8169
>>> driver. Function 0 is bmc virual driver which is used for power
>>> management. This patch set Function 2 to 7 into d3 state when config
>>> hw_config. This helps the whole system enter c10.
>>>
>>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 95
>>> +++++++++++++++++++++++
>>>  1 file changed, 95 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>>> b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 787859b0ab68..d8ffc76186b2 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -1121,6 +1121,100 @@ DECLARE_RTL_COND(rtl_ocp_gphy_cond)
>>>       return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;  }
>>>
>>> +static u32 rtl_other_csi_read(struct rtl8169_private *tp, u8
>>> +multi_fun_sel_bit, int addr) {
>>> +     RTL_W32(tp, CSIAR, (addr & CSIAR_ADDR_MASK) | multi_fun_sel_bit
>> << 16 |
>>> +             CSIAR_BYTE_ENABLE);
>>> +
>>> +     return rtl_loop_wait_high(tp, &rtl_csiar_cond, 10, 100) ?
>>> +             RTL_R32(tp, CSIDR) : ~0; }
>>> +
>>> +static void rtl_other_csi_write(struct rtl8169_private *tp,
>>> +                             u8 multi_fun_sel_bit,
>>> +                             int addr,
>>> +                             int value) {
>>> +     RTL_W32(tp, CSIDR, value);
>>> +     RTL_W32(tp, CSIAR, CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK)
>> |
>>> +             CSIAR_BYTE_ENABLE | multi_fun_sel_bit << 16);
>>> +
>>> +     rtl_loop_wait_low(tp, &rtl_csiar_cond, 10, 100); }
>>> +
>>> +static void rtl8168_clear_and_set_other_fun_pci_bit(struct rtl8169_private
>> *tp,
>>> +                                                 u8 multi_fun_sel_bit,
>>> +                                                 u32 addr,
>>> +                                                 u32 clearmask,
>>> +                                                 u32 setmask) {
>>> +     u32 val;
>>> +
>>> +     val = rtl_other_csi_read(tp, multi_fun_sel_bit, addr);
>>> +     val &= ~clearmask;
>>> +     val |= setmask;
>>> +     rtl_other_csi_write(tp, multi_fun_sel_bit, addr, val); }
>>> +
>>> +static void rtl8168_other_fun_dev_pci_setting(struct rtl8169_private *tp,
>>> +                                           u32 addr,
>>> +                                           u32 clearmask,
>>> +                                           u32 setmask,
>>> +                                           u8 multi_fun_sel_bit) {
>>> +     u32 val;
>>> +     u8 i;
>>> +     u8 FunBit;
>>> +     /* 0: BMC, 1: NIC, 2: TCR, 3: VGA/PCIE_TO_USB, 4: EHCI, 5: WIFI, 6: WIFI,
>> 7: KCS */
>>> +     for (i = 0; i < 8; i++) {
>>> +             FunBit = (1 << i);
>>> +             if (FunBit & multi_fun_sel_bit) {
>>> +                     u8 set_other_fun = true;
>>> +
>>> +                     if (i == 0) {
>>> +                             set_other_fun = true;
>>> +                     } else if (i == 5 || i == 6) {
>>> +                             if (tp->dash_enabled) {
>>> +                                     val = rtl_eri_read(tp, 0x184);
>>> +                                     if (val & BIT(26))
>>> +                                             set_other_fun = false;
>>> +                                     else
>>> +                                             set_other_fun = true;
>>> +                             }
>>> +                     } else {
>>> +                             val = rtl_other_csi_read(tp, i, 0x00);
>>> +                             if (val == 0xffffffff)
>>> +                                     set_other_fun = true;
>>> +                             else
>>> +                                     set_other_fun = false;
>>> +                     }
>>> +                     if (set_other_fun)
>>> +                             rtl8168_clear_and_set_other_fun_pci_bit(tp, i, addr,
>>> +                                                                     clearmask, setmask);
>>> +             }
>>> +     }
>>> +}
>>> +
>>> +static void rtl8168_set_dash_other_fun_dev_state_change(struct
>> rtl8169_private *tp,
>>> +                                                     u8 dev_state,
>>> +                                                     u8
>>> +multi_fun_sel_bit) {
>>> +     u32 clearmask;
>>> +     u32 setmask;
>>> +
>>> +     if (dev_state == 0) {
>>> +             clearmask = (BIT(0) | BIT(1));
>>> +             setmask = 0;
>>> +             rtl8168_other_fun_dev_pci_setting(tp, 0x44, clearmask,
>>> +                                               setmask, multi_fun_sel_bit);
>>> +     } else {
>>> +             clearmask = 0;
>>> +             setmask = (BIT(0) | BIT(1));
>>> +             rtl8168_other_fun_dev_pci_setting(tp, 0x44, clearmask,
>>> +                                               setmask, multi_fun_sel_bit);
>>> +     }
>>> +}
>>> +
>>>  static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg,
>>> u32 data)  {
>>>       if (rtl_ocp_reg_failure(reg))
>>> @@ -3785,6 +3879,7 @@ static void rtl_hw_start_8117(struct
>> rtl8169_private *tp)
>>>       r8168_mac_ocp_write(tp, 0xc094, 0x0000);
>>>       r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
>>>
>>> +     rtl8168_set_dash_other_fun_dev_state_change(tp, 3, 0xfc);
>>>       /* firmware is for MAC only */
>>>       r8169_apply_firmware(tp);
>>>  }
>>
>> This is the type of code that would make r8169 become an unmaintainable
>> mess like the vendor drivers. Why not use standard means like
>> pci_bus_read_config_word() et al?
> 
> Thanks for the suggestion.
> I first tried to use lspci, but I can't find function 2-7 in pci system. Then I tried to
> use pci_bus_read_config_word() to access Function 2-7 and get result as below.
> 
> [21254.984983] RTL8168_DEBUG: Slot 0, Function 2, Read Vendor ID: 0xffffffff
> 
> This confirms that these funcitons are physically hidden from the PCI bus. They do
> not respond to standard PCI configuration cycles, this maybe the reason why standard
> PCI APIs cannot be used here.
> These functions are important for power state issue. When system suspends, linux PCI
> core automatically handles the power transition for the visible functions. But since
> function 2-7 is invisible, the kernel cannot manage it. As a result, we have no choice but
> to use the vendor-specific indirect access mechanism(via CSIAR register).
> 
I understand your pain adding mainline support for broken hw designs. I consider the chip
design fundamentally broken as PCI functions 2-7 are hidden and the ethernet driver is
expected to set power management states for e.g. the EHCI and WiFi functions.
As stated in another comment, the best option seems to me to add support for this chip
downstream only.

> Thanks,
> Javen Xu
> 


