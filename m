Return-Path: <netdev+bounces-181973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51612A873B0
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8907A5B91
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 19:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D71DE4C3;
	Sun, 13 Apr 2025 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="j9kBfSnV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46F1A9B24;
	Sun, 13 Apr 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744573751; cv=none; b=tRlsMPcxBcqsvIILMD/ThNWHKXVT9/ZHWnjy/mH3WxeCZNw+O2uAJNai7TFy7/zNGvDWImMdaGV8C+lvkcZ6b3V8F59VPCKTKh/Rj5oIIwyU94Db4XpggKo0+Vu6woLawvf8oO1dPEEjGv0hILIhI9m6x6JL3ARLIBiFbzm1zPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744573751; c=relaxed/simple;
	bh=3dhDMpst9BKEQZZ9sGqfEcVA9j7hNCxNB2Z6/0BklaM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=n+zZmZXEUwUoSJFZ5iV85+SVio6F6ClW56MF5S8XOukjKnDz5I0EdlDzIFgenQuh/b3JKgpCe85yFsr2ndlHZZO1TzHIG4A7+kmUiCIRF8E5BAR5r3Jo2dWexamGloq3enWfCj35rJyCguSVA7XDi7Fo/54MK1u4f7MjuUSsE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=j9kBfSnV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744573741; x=1745178541; i=wahrenst@gmx.net;
	bh=3dhDMpst9BKEQZZ9sGqfEcVA9j7hNCxNB2Z6/0BklaM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j9kBfSnVmkP4pXK16P2IIyI+Yu0AKsF+C9Smfk+8bj+SrFcAM/1L0+1NVwlCaHWV
	 2YBeVKj3xHck1b4SYwHe6vUzkzQFGhBdLOk62sHDwIA0xZh7Qh472bx9DJEoqAZ4y
	 JQ0WTn7L4ulNrF/Wq9Q9vs6hpJMiQPxGs+fmY+AanF6eZCMhBn+pNceyqu7Kxk3Lh
	 flsPYQ9qgBPmijHFYJMPfra6QlDo6zNTq77mW9meNAvIBvHGWRlC/sboD8SVBdRoj
	 SKI1fXDcfz0U4Xe71lbj1UKqWDf268nMOTNq0LjF7KrtlmlijeDcoS1VFQ7SiKesb
	 IusTmtwfQJU+iVxAMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1tUzcb29lA-00balL; Sun, 13
 Apr 2025 21:49:01 +0200
Message-ID: <3d4bda4e-f4e8-455e-87ec-2a84d6924d76@gmx.net>
Date: Sun, 13 Apr 2025 21:49:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev <netdev@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: lan78xx: Failed to sync IRQ enable register: -ENODEV
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:McXVhsT05CrgRx4E4ZkDOga4rjEwPcE2aMSQd15lKj49k5O0tsa
 rLXd5rAcg6X+Y8iTf4HkhQhXwq+SiAFJaUTAypUtpK+bW/djRGIOj0I2KM+DSn0hK4wZsZ6
 y8lkz7RhVJH/hbDoeADi0ySaMtDXlYoHmEWosKCa53cH2y8ETiuy2IBHSYkgXFCYjGyrYV4
 1qy5HFg1s9YsLHCH1D/Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0fMVsfj+jrY=;/YEp8ylwYLIwN43RgS4s8ZQrI12
 lfppFZ/b5UFz1Pm+GCCEqLqRZ0vG+OeEzANUk7fOymglZZpdi6tTYvJKDcxmqa+yQwYovVno0
 pDokiaYLJZlQ3i/hZS45vTjW0vQqejQinoFTGl2umRIvZKys+SaSOUdJ1EImeeYurzMOHlyQL
 pTIfFl2CXRprxAMGMCV7Q4z4YR0L4Tv9SteIGAFCjabDYivTqT3BH5PTK8c/I3LAyhkll2vWM
 /yXqG7E7ycFbFvze9k5K8SzacW3NRL6Sp+aG+Lh0jsFcsHoVoGjST5u2z6XFHH2l8bi6sV46C
 oNDM8EQndjKa7fYzMhYfNf697C581w49gjCtE97BqTt3wpahRSfV994nH1PeHejiv8niBwluA
 CMX5aMuebA1utNmqkeclk8ihWhiqv+htYr568FKh/pDs/bKr/AtyiZ0N8m2qiBDta3qDvHH4+
 swk2PIIVE2gsl2BQI2hpvC2vVQf8Pe0LunJzYE7M2umdheTyORKGkr9lyp1TLkBlTEzjkek8d
 gukK6fIuPZAuPlF/c/58p1YcMjvUWl+O/N9HR4WSk6+EXXF7BsWIKI8Saffgvv3Dik0AW3yK1
 Ch5c+0t39F0++kpwNbkyypnCxTPnWmRws+UTnezJsvdVoSt/wH3wp4rcFD3A3lRm/CXdBV8sH
 NtW4+OflYaEIO5Qsp6hJ0DXj1OjKsibXk1TlIoIVKdvboA2JR9z60dSLpXgJLE69xqrdL/O0E
 SViMd6w+zpXqGdIj9/HtUzNmGBFDRMm44OLM4FhTYO1SqXyoG9VsychE1L+v2CtmP9H2FKham
 u24TtmyKNK3A5+OmMJiaUtUU+vokBu7HoT4iSe96mPTvFYZhp7A+mRoUFDP7Y7yBdNbC5WUl2
 gsl4wfc5MYKTsxYbrPROghGCP5R8nehkhbqWp5MannR3dGr02wJGmqH6izKQ2x9YG+p4KQ560
 8em1LKDNvKBN8h/Dn5LDG8GBJFuH+kDwO3j3KeMEK8+QkwokV0emH6gVHpNWf6JfJeHuBvSUN
 rKoMF6dGLTFyiXG+QAvlpDf0ooHQd9l1NNquArFmTeAI9rDtyOGnJAiP+dI1FLgUw/kfl4Qbl
 Qvkr5QKBxFn9sqvp99ZQPJy4iAAIT7CzHvgO/uHs6yz1VkRfkVBm/HhmF0orW047H/TagnuAd
 Dry7fnEIj77QR1YN9wwHAMiFhoJ4QByMOQxGw6n/q5nZ0D2RPuzp9eKIUtmevbaoMIqAdy1oU
 YEZ0pLUMeMCTmn4mx4tuSEksSxo2GfQb/rs4LPWpH6Iv3cIkcajpt3karPC8K5pUpnlCL9I31
 rgRD07ykldh+OSVKV7osV8SFWNaaAGape7to/Dsxt2Z2UPp9tf9Gc0rJSMmtlkgFJoZCDGIwq
 /ZFjzd/WSPhldiXIW485bOB6pvDmEZoPUVCIqhjtlpbwyR4M0JFvd9+j4MRN6kF0OD6HP3RGv
 AOjoXSvoEjEgs/G8tw45nlqR2Dao=

Hi,
i noticed that recent changes to lan78xx introduced error messages to
the bootlog of Raspberry Pi 3 B Plus (arm/multi_v7_defconfig, 6.15.0-rc1).

[=C2=A0=C2=A0=C2=A0 8.715374] lan78xx 1-1.1.1:1.0 (unnamed net_device) (un=
initialized):
No External EEPROM. Setting MAC Speed
[=C2=A0=C2=A0=C2=A0 9.313859] usbcore: registered new interface driver lan=
78xx
[=C2=A0=C2=A0 10.132752] vchiq: module is from the staging directory, the =
quality
is unknown, you have been warned.
[=C2=A0=C2=A0 10.533613] usbcore: registered new device driver onboard-usb=
-dev
[=C2=A0=C2=A0 10.533861] usb 1-1.1: USB disconnect, device number 3
[=C2=A0=C2=A0 10.533880] usb 1-1.1.1: USB disconnect, device number 6
[=C2=A0=C2=A0 10.656641] lan78xx 1-1.1.1:1.0 eth0 (unregistered): Failed t=
o sync
IRQ enable register: -ENODEV
[=C2=A0=C2=A0 10.657440] lan78xx 1-1.1.1:1.0 eth0 (unregistered): Failed t=
o sync
IRQ enable register: -ENODEV
[=C2=A0=C2=A0 10.658819] usb 1-1.1.2: USB disconnect, device number 5

Since this happend during only two times during boot, i added a
WARN_ON() in this specific case in order to see what's going on:

[=C2=A0=C2=A0 10.655832] ------------[ cut here ]------------
[=C2=A0=C2=A0 10.655865] WARNING: CPU: 1 PID: 161 at
drivers/net/usb/lan78xx.c:2442 lan78xx_irq_bus_sync_unlock+0x94/0xb0
[lan78xx]
[=C2=A0=C2=A0 10.655903] Modules linked in: soundcore onboard_usb_dev(+) d=
rm_exec
ecdh_generic drm_dma_helper ecc raspberrypi_hwmon libaes bcm2835_thermal
vchiq(C) microchip lan78xx
[=C2=A0=C2=A0 10.655966] CPU: 1 UID: 0 PID: 161 Comm: systemd-udevd Tainte=
d:
G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.15.0-rc1-00002-g5f5bffb44607-dirty #43=
1 NONE
[=C2=A0=C2=A0 10.655976] Tainted: [C]=3DCRAP
[=C2=A0=C2=A0 10.655980] Hardware name: BCM2835
[=C2=A0=C2=A0 10.655984] Call trace:
[=C2=A0=C2=A0 10.655999]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0=C2=A0 10.656027]=C2=A0 show_stack from dump_stack_lvl+0x50/0x64
[=C2=A0=C2=A0 10.656043]=C2=A0 dump_stack_lvl from __warn+0x80/0x128
[=C2=A0=C2=A0 10.656062]=C2=A0 __warn from warn_slowpath_fmt+0x170/0x178
[=C2=A0=C2=A0 10.656076]=C2=A0 warn_slowpath_fmt from
lan78xx_irq_bus_sync_unlock+0x94/0xb0 [lan78xx]
[=C2=A0=C2=A0 10.656092]=C2=A0 lan78xx_irq_bus_sync_unlock [lan78xx] from
free_irq+0x308/0x318
[=C2=A0=C2=A0 10.656110]=C2=A0 free_irq from phy_disconnect+0x2c/0x48
[=C2=A0=C2=A0 10.656131]=C2=A0 phy_disconnect from lan78xx_disconnect+0x80=
/0x14c [lan78xx]
[=C2=A0=C2=A0 10.656143]=C2=A0 lan78xx_disconnect [lan78xx] from
usb_unbind_interface+0x7c/0x290
[=C2=A0=C2=A0 10.656161]=C2=A0 usb_unbind_interface from
device_release_driver_internal+0x180/0x1f4
[=C2=A0=C2=A0 10.656177]=C2=A0 device_release_driver_internal from
bus_remove_device+0xc0/0xe4
[=C2=A0=C2=A0 10.656193]=C2=A0 bus_remove_device from device_del+0x138/0x4=
24
[=C2=A0=C2=A0 10.656209]=C2=A0 device_del from usb_disable_device+0xc4/0x1=
70
[=C2=A0=C2=A0 10.656223]=C2=A0 usb_disable_device from usb_disconnect+0xdc=
/0x270
[=C2=A0=C2=A0 10.656238]=C2=A0 usb_disconnect from usb_disconnect+0xa8/0x2=
70
[=C2=A0=C2=A0 10.656252]=C2=A0 usb_disconnect from hub_quiesce+0x68/0xb4
[=C2=A0=C2=A0 10.656268]=C2=A0 hub_quiesce from hub_disconnect+0x38/0x164
[=C2=A0=C2=A0 10.656284]=C2=A0 hub_disconnect from usb_unbind_interface+0x=
7c/0x290
[=C2=A0=C2=A0 10.656298]=C2=A0 usb_unbind_interface from
device_release_driver_internal+0x180/0x1f4
[=C2=A0=C2=A0 10.656309]=C2=A0 device_release_driver_internal from
bus_remove_device+0xc0/0xe4
[=C2=A0=C2=A0 10.656320]=C2=A0 bus_remove_device from device_del+0x138/0x4=
24
[=C2=A0=C2=A0 10.656333]=C2=A0 device_del from usb_disable_device+0xc4/0x1=
70
[=C2=A0=C2=A0 10.656345]=C2=A0 usb_disable_device from usb_set_configurati=
on+0x504/0x8e0
[=C2=A0=C2=A0 10.656358]=C2=A0 usb_set_configuration from usb_unbind_devic=
e+0x24/0x7c
[=C2=A0=C2=A0 10.656371]=C2=A0 usb_unbind_device from
device_release_driver_internal+0x180/0x1f4
[=C2=A0=C2=A0 10.656380]=C2=A0 device_release_driver_internal from device_=
reprobe+0x18/0x90
[=C2=A0=C2=A0 10.656391]=C2=A0 device_reprobe from __usb_bus_reprobe_drive=
rs+0x40/0x6c
[=C2=A0=C2=A0 10.656407]=C2=A0 __usb_bus_reprobe_drivers from bus_for_each=
_dev+0x6c/0xb4
[=C2=A0=C2=A0 10.656421]=C2=A0 bus_for_each_dev from usb_register_device_d=
river+0x94/0xc8
[=C2=A0=C2=A0 10.656434]=C2=A0 usb_register_device_driver from
onboard_dev_init+0x14/0x1000 [onboard_usb_dev]
[=C2=A0=C2=A0 10.656460]=C2=A0 onboard_dev_init [onboard_usb_dev] from
do_one_initcall+0x40/0x1e0
[=C2=A0=C2=A0 10.656480]=C2=A0 do_one_initcall from do_init_module+0x50/0x=
1fc
[=C2=A0=C2=A0 10.656497]=C2=A0 do_init_module from init_module_from_file+0=
x90/0xbc
[=C2=A0=C2=A0 10.656513]=C2=A0 init_module_from_file from sys_finit_module=
+0x194/0x2b0
[=C2=A0=C2=A0 10.656528]=C2=A0 sys_finit_module from __sys_trace_return+0x=
0/0x10
[=C2=A0=C2=A0 10.656542] Exception stack(0xf1bf9fa8 to 0xf1bf9ff0)
[=C2=A0=C2=A0 10.656550] 9fa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b6f5bf0=
4 00000040 00000006
b6f5ad00 00000000 b6f5ba78
[=C2=A0=C2=A0 10.656556] 9fc0: b6f5bf04 00000040 6ebbc400 0000017b 006dac1=
8
005a196b 005a19dc 006dbae0
[=C2=A0=C2=A0 10.656562] 9fe0: bee066c8 bee066b8 b6f52bc8 b6dfc580
[=C2=A0=C2=A0 10.656581] ---[ end trace 0000000000000000 ]---

Maybe some has any idea, how to fix this properly.

Best regards

