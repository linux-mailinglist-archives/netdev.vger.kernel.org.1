Return-Path: <netdev+bounces-180433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D13DA814EB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1863B2919
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A321325C;
	Tue,  8 Apr 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="WjZwsQSH";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="DGTzVuZV"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63E23A0;
	Tue,  8 Apr 2025 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138050; cv=pass; b=WQ2dUYxmNUvll3gCPbFyhqWd3COTDx5buFOLS7zGmTkUMsQs7Rs84V4SpI85PV0LdT33SpApkarctBUfbLmEDPH48QYESXzoHaDNTPiczFWl1ID8Ocu1A/ho6h5WH0X4J2PfIPIMibhrexQAvGcOPahm2c5nOfYmiRAF2chWyVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138050; c=relaxed/simple;
	bh=UCpJcbNTpC+USecP0R/5Q0caeFOcwevLKiPG1XG1oos=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfxVXX56PbCxR21mpMoqA6BCMo93rWN+i8+qYq9vqBActd8hIklF0upB4Sg2gu26IO915mOtbJrJY6T2Usk5g4Lz+/fva/oDJ183cjCjhC9YiMOhBEMTP6WthUnJpKVgcHYil+8EoqV3HwpOt5Dpg9ss7FQDsb68bMVW4Xt1fY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=fossekall.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=WjZwsQSH; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=DGTzVuZV; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fossekall.de
ARC-Seal: i=1; a=rsa-sha256; t=1744138043; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tK/oae5fJUev9lwxy+XZPQcO23vWatZsVTDIEZM8SI2gqCJfDawCgxr5fS423wve/f
    phaYFDNwQBW1L9Fift0saKu6u6GrGh4RvbEjy5Vc05m/HxjS/ZglsA3seazZgsRUnvut
    hdXibt7usUBfHsguVwyP5txkTEqubNv3k6rS4KIJV2CjVmD4tFqNi730yDDGpQ/Va9G6
    amK4M/RDHQVPVkCvIcnb1Fc/h4xL8AGcpi9N5TzZzoypdJ6Rj8IXlDlBlmXGYzkr9f8M
    bjrGMwACdq7IcXY0zRwu0oblYQQLrq8Wg/g6VJMSWER2TTYD1SfmD1+XIrKuWmuuUgbH
    KWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744138043;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=JrbJav81393rily8U3ZYwXIVZ7I5lCu0WEy1TvuEyws=;
    b=BLOis1srZjr3C96QZq0i8nXnI6BzaR5EdpryFQX7uxA1uy1COSba0z2FREtKA6w2eq
    rxQ3UkCcx/KOdGoJb3/3WXlg6DvvxkNTlnJ13+P4UCYu0b9Pl4P/dmF8T8EJKQ9PSMZp
    gM9JrU1cgRxe2g3g9Z9s4vwE4tw7YAmgiENEXuGSwGY0ibPhstI2yAgGnrims3qJ5/zV
    F5F5699yYqqDNHGSEXUF3QXNcxrhXJCvco35epJtYLg1Xx7omhV9GRafrLdrdVD6KOKG
    8FGo5M4XE/812E3hC+CfbtU0C/hahBU9dE0okfPjlViyLos04QGIoX+oaDAq/NQYzAFb
    ms5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744138043;
    s=strato-dkim-0002; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=JrbJav81393rily8U3ZYwXIVZ7I5lCu0WEy1TvuEyws=;
    b=WjZwsQSH6BBDCOV150UOO5OCdnF7VNHe5/iTuTTGy3LCCPmgUb3ClPegG9B/qqp2ow
    2zxKdbmkLR7sC/U76CgaUXQOHYY0ArhOHebV3cbNKotKqtZos+ascATlZMWAVJ1NXG3J
    pmOuL+ozP+lQmKUSOgOv3RgXqOP2WZC6VgcOz1ELSRw4KLQRJnMuvoVYpLDfIVd44CWy
    iRjimhqYXoQd0KWgQPMHDXfwIPh6BZYfdAFBKE7Wcp5jhnpv2r6Sq3O22sqzhfF08loT
    D4zNzdt6T+K17bwYqimt9eq72j+Yq8RuxSUunPx8gm5BReURvcGeAqBtleLW2R2KslL0
    jZ2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744138043;
    s=strato-dkim-0003; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=JrbJav81393rily8U3ZYwXIVZ7I5lCu0WEy1TvuEyws=;
    b=DGTzVuZVCSMdpr/CArxinpM9RxN3yCUeSCFXbsE0zrZqAraSxGqtNvj0+O5g/vrRRg
    qxvjLK+aZLze1z4wm5AA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35138IlM45N
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 8 Apr 2025 20:47:22 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <michael@fossekall.de>)
	id 1u2Dyk-0008Ot-04;
	Tue, 08 Apr 2025 20:47:22 +0200
Date: Tue, 8 Apr 2025 20:47:20 +0200
From: Michael Klein <michael@fossekall.de>
To: Joe Damato <jdamato@fastly.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND net-next v5 2/4] net: phy: realtek: Clean up RTL8211E
 ExtPage access
Message-ID: <Z_VvOG91oPZZejye@a98shuttle.de>
References: <20250407182155.14925-1-michael@fossekall.de>
 <20250407182155.14925-3-michael@fossekall.de>
 <Z_SQTi-uKk4wqRcL@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z_SQTi-uKk4wqRcL@LQ3V64L9R2>
Content-Transfer-Encoding: 7bit

On Mon, Apr 07, 2025 at 07:56:14PM -0700, Joe Damato wrote:
>> - Factor out RTL8211E extension page access code to
>>   rtl8211e_modify_ext_page() and clean up rtl8211e_config_init()
>>
>> Signed-off-by: Michael Klein <michael@fossekall.de>
>> ---
>>  drivers/net/phy/realtek/realtek_main.c | 38 +++++++++++++++-----------
>>  1 file changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
>> index b27c0f995e56..e60c18551a4e 100644
>> --- a/drivers/net/phy/realtek/realtek_main.c
>> +++ b/drivers/net/phy/realtek/realtek_main.c
>> @@ -37,9 +37,11 @@
>>
>>  #define RTL821x_INSR				0x13
>>
>> -#define RTL821x_EXT_PAGE_SELECT			0x1e
>>  #define RTL821x_PAGE_SELECT			0x1f
>>
>> +#define RTL8211E_EXT_PAGE_SELECT		0x1e
>> +#define RTL8211E_SET_EXT_PAGE			0x07
>> +
>>  #define RTL8211E_CTRL_DELAY			BIT(13)
>>  #define RTL8211E_TX_DELAY			BIT(12)
>>  #define RTL8211E_RX_DELAY			BIT(11)
>> @@ -135,6 +137,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
>>  	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
>>  }
>>
>> +static int rtl8211e_modify_ext_page(struct phy_device *phydev, u16 ext_page,
>> +				    u32 regnum, u16 mask, u16 set)
>> +{
>> +	int oldpage, ret = 0;
>> +
>> +	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
>> +	if (oldpage >= 0) {
>> +		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
>> +		if (ret == 0)
>> +			ret = __phy_modify(phydev, regnum, mask, set);
>> +	}
>> +
>> +	return phy_restore_page(phydev, oldpage, ret);
>> +}
>> +
>>  static int rtl821x_probe(struct phy_device *phydev)
>>  {
>>  	struct device *dev = &phydev->mdio.dev;
>> @@ -607,7 +624,9 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
>>
>>  static int rtl8211e_config_init(struct phy_device *phydev)
>>  {
>> -	int ret = 0, oldpage;
>> +	const u16 delay_mask = RTL8211E_CTRL_DELAY |
>> +			       RTL8211E_TX_DELAY |
>> +			       RTL8211E_RX_DELAY;
>>  	u16 val;
>>
>>  	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
>> @@ -637,20 +656,7 @@ static int rtl8211e_config_init(struct phy_device *phydev)
>>  	 * 12 = RX Delay, 11 = TX Delay
>>  	 * 10:0 = Test && debug settings reserved by realtek
>>  	 */
>> -	oldpage = phy_select_page(phydev, 0x7);
>> -	if (oldpage < 0)
>> -		goto err_restore_page;
>> -
>> -	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0xa4);
>> -	if (ret)
>> -		goto err_restore_page;
>> -
>> -	ret = __phy_modify(phydev, 0x1c, RTL8211E_CTRL_DELAY
>> -			   | RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
>> -			   val);
>> -
>> -err_restore_page:
>> -	return phy_restore_page(phydev, oldpage, ret);
>> +	return rtl8211e_modify_ext_page(phydev, 0xa4, 0x1c, delay_mask, val);
>>  }
>
>Seems good to add RTL8211E_SET_EXT_PAGE to remove a constant from
>the code. Any reason to avoid adding constants for 0xa4 and 0x1c ?

My copy of the datasheet does not document this register, so I did not
feel qualified to come up with a meaningful name.

