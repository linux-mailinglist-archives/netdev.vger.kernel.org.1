Return-Path: <netdev+bounces-97286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F298CA802
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B135B1F212CE
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 06:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11B44384;
	Tue, 21 May 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="cKwrVJCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4814286
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272842; cv=none; b=Jtz7a4C4f2/dN7m3bzVOVkVD7Pua0DqnErniNltjyUl4IAkF5ov7YjnTWyt/HAdhEZaMzGyTQ5wW2rQ3cDLY6Xi+ycrlgT5M0kTPYqgphp0Ohn1jezoxS+lcTgQ4ZXT4kCiTehLc9gHItUPCGKtNHC/FnPetN0nBVbHm9VDMKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272842; c=relaxed/simple;
	bh=5aK1DL+CCxy0pWhR4EcGucXtFqVpHfn/bkONsXTksKs=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qHIwEEG+KhZfWtc5/afYP6arm6fUq897zV1S23gzrM2QO49HryuDyXRCuap6kn76lXhwe/VpUUAkdIIX8Hhk4zrQaH7431IUpWO0QyUEXRvaubVRVy9FNOd8pgFVYi+/7Xu3yjHuAIq8vqMhVhh4HDaLl8BO1y5kTNc5xUGG6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=cKwrVJCs; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44L6QxTq031984
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 21 May 2024 08:27:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1716272822; bh=J6nGwAmrgaao+lbg/4xoH4jUnrt7ZCIMll2821NWE78=;
	h=Date:From:To:Cc:Subject;
	b=cKwrVJCsIDIHohuc0h9Xd3d4AMksN62XT3RMUHcRNiquo/+BmYcQkX2oXn99blATw
	 VLbWMhIYQ0iIdDXQsRmLkFMFpBFFnxGvhBS3ez7dd1oxLjHRb/UsrBqVFa9KMVIhSi
	 CGsDtKkoIqOrYEusZYVK7Nou4qxbiJo5bXrQ9d1E=
Message-ID: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
Date: Mon, 20 May 2024 23:26:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
To: Michal Kubecek <mkubecek@suse.cz>,
        Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

After upgrading from 5.4-stable to 6.6-stable I noticed that modern ethtool -m stopped working with ports where I have QSFP modules installed in my CX3 / CX3-Pro cards.

Git bisect identified the following patch as being responsible for the issue:
https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=25b64c66f58d3df0ad7272dda91c3ab06fe7a303

Without the patch, I get the following output:
# ./ethtool --debug 3 -m eth3
        Identifier                                : 0x0d (QSFP+)
        Extended identifier                       : 0x00
        Extended identifier description           : 1.5W max. Power consumption
        Extended identifier description           : No CDR in TX, No CDR in RX
        Extended identifier description           : High Power Class (> 3.5 W) not enabled
        Connector                                 : 0x0c (MPO Parallel Optic)
        Transceiver codes                         : 0x00 0x00 0x30 0x00 0x00 0x00 0x00 0x00
        Transceiver type                          : SAS 6.0G
        Transceiver type                          : SAS 3.0G
        Encoding                                  : 0x01 (8B/10B)
        BR, Nominal                               : 0Mbps
        Rate identifier                           : 0x00
        Length (SMF,km)                           : 0km
        Length (OM3 50um)                         : 0m
        Length (OM2 50um)                         : 0m
        Length (OM1 62.5um)                       : 0m
        Length (Copper or Active cable)           : 0m
        Transmitter technology                    : 0x00 (850 nm VCSEL)
        Laser wavelength                          : 850.000nm
        Laser wavelength tolerance                : 10.000nm
        Vendor name                               : AVAGO
        Vendor OUI                                : 00:17:6a
        Vendor PN                                 : <REDACTED>
        Vendor rev                                : A0
        Vendor SN                                 : <REDACTED>
        Date code                                 : <REDACTED>
        Revision Compliance                       : Revision not specified
        Module temperature                        : 40.07 degrees C / 104.13 degrees F
        Module voltage                            : 3.2914 V
        Alarm/warning flags implemented           : No
        Laser tx bias current (Channel 1)         : 6.556 mA
        Laser tx bias current (Channel 2)         : 0.000 mA
        Laser tx bias current (Channel 3)         : 0.000 mA
        Laser tx bias current (Channel 4)         : 0.000 mA
        Transmit avg optical power (Channel 1)    : 0.8101 mW / -0.91 dBm
        Transmit avg optical power (Channel 2)    : 0.0000 mW / -inf dBm
        Transmit avg optical power (Channel 3)    : 0.0000 mW / -inf dBm
        Transmit avg optical power (Channel 4)    : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 1)  : 0.5716 mW / -2.43 dBm
        Rcvr signal avg optical power(Channel 2)  : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 3)  : 0.0000 mW / -inf dBm
        Rcvr signal avg optical power(Channel 4)  : 0.0000 mW / -inf dBm

With the patch (included in ethtool-5.13):
# ./ethtool --debug 3 -m eth3
sending genetlink packet (32 bytes):
    msg length 32 genl-ctrl
received genetlink packet (956 bytes):
    msg length 956 genl-ctrl
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (176 bytes):
    msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (176 bytes):
    msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (96 bytes):
    msg length 96 error errno=-22
netlink error: Invalid argument

I suspect this works on the older kernels because of the lack of netlink support (which got introduced somewhere between 5.4 and 6.6), so ethtool automatically fallbacks to the ioctl interface:

sending genetlink packet (32 bytes):
    msg length 32 genl-ctrl
received genetlink packet (52 bytes):
    msg length 52 error errno=-2
(...)

Also note that non-DOM SFP does work:
# ./ethtool --debug 3 -m eth2
sending genetlink packet (32 bytes):
    msg length 32 genl-ctrl
received genetlink packet (956 bytes):
    msg length 956 genl-ctrl
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (176 bytes):
    msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
received genetlink packet (36 bytes):
    msg length 36 error errno=0
sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
received genetlink packet (176 bytes):
    msg length 176 ethool ETHTOOL_MSG_MODULE_EEPROM_GET_REPLY
received genetlink packet (36 bytes):
    msg length 36 error errno=0
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
        (...)

Still need to check if SFP w/DOM works, but it seems we are missing reporting "Optical diagnostics support" as sff8472_show_all() is only called only for the non-netlink interface?

Compiling ethtool with --disable-netlink also fixes both the problems, but obviously this is just a workaround.

Thanks,
 Krzysztof Olędzki

