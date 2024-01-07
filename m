Return-Path: <netdev+bounces-62242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C19826543
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FBA1C209F0
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E0134D3;
	Sun,  7 Jan 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WimhEGzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42413ADE
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ccbded5aa4so11065621fa.1
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 09:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704647453; x=1705252253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WWRtXDsgMJNv2Wf8/xfz00ReG5RoHh//8Rc8gzsXa/Y=;
        b=WimhEGzK/Ap8zTVt0qcKMmxsT2TDzkK6opjltU+wpnfU5ax9cWke86dGwUwbtzrubd
         3frWzEhJuLZrt74aJ7uwF7HURRMMFYfQNl4zBtv0YJe2tyLjwWOSE5C11c63l2gjlOTu
         5ZQEHPjM9x+D2upAX1Cb3WiU1D4p9kaR85GYq7E/SwHssWM4O/GI0nTCQ3jM8oOjM0w9
         NlKIzhPLJZGaKnKSDwrjGR2S68eZGlZSaetdOAyJ2tU4tHG/DzxRPMO0Zw5/FIn6mWLs
         a24tdegmyaq7DbH2NsC3KBmJ7Ixt23Asqv9lDaqfS5MaZQ0utDaSKDUFGpXmcd+wJxgv
         mJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704647453; x=1705252253;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWRtXDsgMJNv2Wf8/xfz00ReG5RoHh//8Rc8gzsXa/Y=;
        b=oQnRcg9ik9zCzwCGABuwagMGRpoW6acWoHK59E1INPrEdZxCpuc1VrWVxGbCmb8hnc
         KCAMQkA9R7j0+9ps0HRLeu3kE2hpQyb0rtD1UdXGfTD7j39mqF0WYvh2SzT77Eb13m/A
         IYpG4bu+NIbo+XQLYPC8Hw5ox8dUddszrM4uv7ZQXvwOJG2cEbV5kaQcRBvQJ4aAhS6+
         gLyGZWl/hO6b2Af3ET5WBspWy8/UyC1izsRstSxKm9oEQzpuah8Q9kIa/rKQul6ZRpjp
         amHLMMPOeS3iDLDFQNhjHEcWs3g/8fESiIaKQbfjqKt2bHtuWbWVhZextH9WPP9CcyIt
         lKGA==
X-Gm-Message-State: AOJu0YympzXNv4gkED+f/y+ufG2mK2WsAHvnV0lilty580ttBx/AsLPq
	xQbiUYE3x1Rgf29N5RtO9b4=
X-Google-Smtp-Source: AGHT+IHkchlzDiX6oGzOO3CG6NW+eUFcIDH4Qq4rEy8ShMa6l+BExl2L8FwkUetQ40BQ3Bfugh9wyw==
X-Received: by 2002:a2e:8896:0:b0:2cc:671c:a449 with SMTP id k22-20020a2e8896000000b002cc671ca449mr1016335lji.2.1704647452482;
        Sun, 07 Jan 2024 09:10:52 -0800 (PST)
Received: from ?IPV6:2a01:c23:c4fa:1c00:e12e:52d:1303:8525? (dynamic-2a01-0c23-c4fa-1c00-e12e-052d-1303-8525.c23.pool.telefonica.de. [2a01:c23:c4fa:1c00:e12e:52d:1303:8525])
        by smtp.googlemail.com with ESMTPSA id fk8-20020a056402398800b005579dbd7c4csm717357edb.35.2024.01.07.09.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 09:10:51 -0800 (PST)
Message-ID: <e67d3de9-65b2-4dac-8b87-2bbf09ea3c21@gmail.com>
Date: Sun, 7 Jan 2024 18:10:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RFC 2/5] ethtool: switch back from ethtool_keee to
 ethtool_eee for ioctl
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
 <ba3105df-74ae-4883-b9e9-d517036a73b3@gmail.com>
 <533a25a0-e1a1-447a-a0ea-7fad0e02c28a@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <533a25a0-e1a1-447a-a0ea-7fad0e02c28a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.01.2024 17:23, Andrew Lunn wrote:
>>  static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
>>  {
>> -	struct ethtool_keee edata;
>> +	struct ethtool_keee keee;
>> +	struct ethtool_eee eee;
>>  	int rc;
>>  
>>  	if (!dev->ethtool_ops->get_eee)
>>  		return -EOPNOTSUPP;
>>  
>> -	memset(&edata, 0, sizeof(struct ethtool_keee));
>> -	edata.cmd = ETHTOOL_GEEE;
>> -	rc = dev->ethtool_ops->get_eee(dev, &edata);
> 
> With the old code, the edata passed to the driver has edata.cmd set to
> ETHTOOL_GEEE.
> 
>> -
>> +	memset(&keee, 0, sizeof(keee));
>> +	rc = dev->ethtool_ops->get_eee(dev, &keee);
> 
> Here, its not set. I don't know if it makes a difference, if any
> driver actually looks at it. If you reviewed all the drivers and think
> this is O.K, i would suggest a comment in the commit message
> explaining this.
> 
I saw your comment on patch 3, just to explain this a little bit more:
The cmd field is set for ioctl only (by userspace ethtool), it's not
populated for netlink. Therefore no driver should use it.
Also it wouldn't make sense. If get_eee() is called, then cmd must
have been set to ETHTOOL_GEEE (for ioctl). See __dev_ethtool().

We could even remove setting cmd here. Userspace ethtool isn't
interested in the cmd field of the GEEE response.

-	if (copy_to_user(useraddr, &edata, sizeof(edata)))
+	keee_to_eee(&eee, &keee);
+	eee.cmd = ETHTOOL_GEEE;
+	if (copy_to_user(useraddr, &eee, sizeof(eee)))
 		return -EFAULT;

> 	   Andrew

Heiner


