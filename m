Return-Path: <netdev+bounces-186323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5FA9E49D
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 22:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E463AA4B2
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5331FAC59;
	Sun, 27 Apr 2025 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="DDmCz5Ti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048F211C;
	Sun, 27 Apr 2025 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745787373; cv=none; b=kycxRZgmkb1VvzYEqtFWmGMFT108SDQ5Zgpw4t8fnb2riL+R/D5PBUISxxC/+Y5xb6LqxE/p0nE1xm2SL8Y4q0Q7U9nyAiDKrEQ/ILRzxgFsHkjq5qNeG7dmYORqqEU214QbEQr79GX2LGYSVL0oyZ6vDmzmrqMwORRhcotPphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745787373; c=relaxed/simple;
	bh=UBR+DNEJafbXedpk+z2kPk/t2Z8YXWMQJ/Yyer8ZIZc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=loc+TJLxu0XQf3exRKor/VRdytX4HvIQT2nMREdCfJdGxMJJlsDNFfslDgc1mb6J75Lyubhtn75W7iyfWrmVF1yOHtdGx6B9q8C52dNUwaXUyuhqsP+qjzmD3zhBXZF/OipAv4ksbM61u0Yh/bGBd/VxKOeO+Zr7nGfc9zFm/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=DDmCz5Ti; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1745787039;
	bh=UBR+DNEJafbXedpk+z2kPk/t2Z8YXWMQJ/Yyer8ZIZc=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To:From;
	b=DDmCz5TisABFCbUD2S9+VQzFOb52mlmWWMKllZcP4iuPWT3wYn7aCnxMU5XBDzZgS
	 vs1DEdUoyhV83qYROdsg6jS4JP3K81DaJ3nYE3KdSya1DJ+C8Yl28NBKaoApV/IzC5
	 fJt8Ja++9LWyT/9FJ5p6MUPmwcH02urOaWWFEkbZXmcN67juVRj/td3LaYsfJLQsOk
	 11mNBm1DfoSw9dFlcm0N6kRaOE5hPTLBjSrvYYSOZ+w/Z7sq89OXLDFiG0etnqjJgF
	 e3HZTskkLht+Ty5LvW5bh7Maeq5rqOqTwBYi2Y+wyjmIrEUTTwasMHLtbRhXtWFQXB
	 WMfp8HL3ZBOwQ==
Received: from [192.168.0.100] (dslb-084-060-118-083.084.060.pools.vodafone-ip.de [84.60.118.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id B0E6020352;
	Sun, 27 Apr 2025 22:50:38 +0200 (CEST)
Message-ID: <9b822fe6-699a-4fe6-88c5-1e92e6a6e588@math.uni-bielefeld.de>
Date: Sun, 27 Apr 2025 22:50:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: pmenzel@molgen.mpg.de
Cc: davem@davemloft.net, edumazet@google.com, frederic@kernel.org,
 hayeswang@realtek.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, romieu@fr.zoreil.com
References: <8db2e1cd-553e-4082-a018-ec269592b69f@molgen.mpg.de>
Subject: Re: [PATCH 2/2] r8152: Call napi_schedule() from proper context
Content-Language: en-US
From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; keydata=
 xsFNBFZhiNQBEAC5wiHN+jpZllNh3qv6Ni+32m4begD1A51ezJGHvubpy04S7noJ3BZvGeMf
 VBgp0ap0dtF3LHHKb5DRhakxU95jv3aIgVZCPztsZP7HLwwwdfI56PAy3r8IyvMxgokYZczM
 lPWcgYxV/cous+oLX/QjeTQ8GKkZqEfg0hK/CiBjenmBzc0BB2qlalMQP333113DIPYPbD97
 3bA94/NBLlIf4HBMvvtS65s5UUtaAhnRBJ31pbrZnThwsQBktJp6UunOWGpvoPGJV5HYNPKg
 KKyuXkJbcN8rS3+AEz1BIlhirl+/F4MZKootDIE+oPmVtgY7wZWwHTatEgjy6D/DKgqUsfwW
 W/6jqYpOHRTw1iRh/vVvQ6/NCALwy0hlQWPSrA2HwjJSjwotv92mEG7+jQAjAbnFR9kaIaQa
 g4svIlP//hRb1ISloTl+/H5lnep2Jb3/fVS6sNEnaXVvPdcC1gUVddyMN7sJOgzn6IM6vx6l
 jq50hT3lIiTnKSqxOV7uNQdF85k43M208FT63GMKHJAmWsfPCOZJCY+tmkl5ezeN43iZ9W0q
 rsvaFpTtM4Aupjs826OIsx07PmCQFG5UtFVYK1ApoRzCp01zkW/UDN/Y1knC6SMvqY2O2u2J
 nhTG3+oTyvkpWtd4b1ozcUw7WNt2fY4xVXnt6yYvj+UcxEE2qwARAQABzS1Ub2JpYXMgSmFr
 b2JpIDx0amFrb2JpQG1hdGgudW5pLWJpZWxlZmVsZC5kZT7CwZUEEwEIAD8CGyMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAFiEEGeEB3B9OrXiyOyWfPuG7f7PKIigFAmeozMYFCRUJqusA
 CgkQPuG7f7PKIihaWQ/9EVd1bb2UqfELsVYt4v0DJnrnHWpmUpkrfQDcCqYPwuZp936TLgHa
 DUp2e3sXLEOBuTXlL9VPfSQENYjiUfMEARNStaKQWmAMIWbGWPi6AVIefMo05sUYJpSxjei7
 xnx4UmrfY8h0yZ1+BYgc23X7cs5AZcQq4ag5+M35MV+1r/opeN1M28uqRHt2+aHvXed7mce6
 FPIGcuI/rVevKUXcnZLatINptzEZg6QSP8h30ZGnNiE9JtbWO6uAWH/sWFMVvoHOTRMMmK7u
 6kjM81XT211zWzGIou4zN6SMfo2lQKFEQRAxba9MSlfSfcbYPNAOnDVbaIF+nsCHyZQEwYIn
 OA2mjjw2ZZ5H3RaY7KRJsZaNjWmg14HMAVhETiMCyN3ZUKadVlQRdcE04x2/Dh/rCbQR+Bkx
 ooB4KEGdtkbB5JOd95OJmYtBqS5lgqm+xAe+4IDfcssbJ+qChbnKtB0nGul1AcnmXvNebc5T
 hcCe5btwbxWwd0rmc2vd51AXvwmAxq9zMG7xPAwYaXGKwNOPL6yBO+FHo0VuOMdew0iuBTzj
 QYLaXTfmxu0R/tQOBn6FeKXAXaCQrH/+UghIoddoV8ODfg9RlysYroeqP1WBMNO0/r9TSW6Q
 +LmvtGjuguBJEFQWw1WKpebcvxdLt5M4LsJ4KpWy6apsWPwer/AEXoHOwU0EVmGI1AEQAMw4
 NG4e0lhPiy9C7ig0vwTA6IkU8LI6SiXmt90iZg+zi2vYTihz+WHqqDsFKIz8nw1vOC4sdIzJ
 8Sek623B178XOyATJ4Z2kF4FjzMbtzlAb965xdfE4vFIqgW89Dze/rv/eQ0UHuIKLu1ere9r
 B5ji8Sd9wksM81+MJI5Wd5OWpAmRk3DJrs1S3haZHbQzkAvjRaXlboSex7az3TIFU0JNFrTE
 Ym1AeM3kuJP4L2kcx7DtkzIf+kuL4w1L2RXaq0J/XiOoygTUD4MKy4iQZt2aLXqNvxbA0I4E
 jRvN82peVkHd/JcoygLkLecj7w1QZXY3vtLYmK5aF/mAGXpmpOMoMUPv5nyRVubzw0XAktYz
 6suh/kv+t4FSSLDxKYL31j2iuckBwK6b+JQ5MQv5bLiyV+4knqAf8kaeVlbnrfiaeBKl6iZG
 tsezb7HoJdDi3vL9W8tgY21v/6/usvR48YjIUieiTdQvMP+SIkLPps+vgIurm0cdTxg5aPBs
 cObGf3v1sfXoZO9kXgzZh0OOmzM6eQMLEIg+/fGq3ceBNYGWe2CEy/dJYPfp+j1kRDa10RKz
 DS4O5Sed8+EoL2uBcR9MZZrQKXSeBRkcdcr9pmWYLtZeYA5eHENZ5cI9B4p1y/Ov5tbyhb4b
 aoY8AA4iJQL13PpLIpxCCX4nWZHOa6ZBABEBAAHCwXwEGAEIACYCGwwWIQQZ4QHcH06teLI7
 JZ8+4bt/s8oiKAUCZ6jM1QUJFQmrAQAKCRA+4bt/s8oiKIptD/9+Mjb4K8Z+zM7h9ESmpa+U
 3ckdGB1MS/ty+nsr+pSBTprd2tBR7HQO6C9Eb5hx2EJT74VE2Wl7pYaj1DoEQ7J99/xsnmBw
 DaKXsrpnyNtXSF6qOPTQ524PjT2Sz3aji+S5li0Ej3eqAxsf9Jl4dQVIcDeh/8VUxl88GtOU
 gPxq7r/5TB6idOZIdjklB5T6CdISBcducCw4+ltWBwGscRSeDHmcSZOgYnwWdabO0JyREGRa
 7xQm9bt8V6vXiK8S4fnV3VnIbavzQ3GdH1eZ7ic2YeFoI1pcbRgZUhFXACARNk2ueAsNR94X
 kb45Frzf5Uz/afKE+5V146MtW3IEq9ZZnXjl5Ao2GKYda5lr3YzcmRHi7n7t5ptZbmzP/u3S
 yrafVwfFMkgGqFEJk6Ap7iT6SJFkbQB4UL1zMk8Kqc9bZnNb/GZ8d1EZ//2dQUb6CgSlDLRY
 6QjU+SxYQlcSGz9kvxf7Fru0zrJVEumtfQL61PS/iFUYqkSwWo6WOvLJ5A2dQ+o+WkjdKgrA
 0qZnyRyYrD8Ehim/hhe5cgUNxpW+LmoUrp1mXHoF9K8YHsEMbew+4Ap8XUgnNVb8/94gvnjv
 iMXY2n/cZX1hgBoQVF/mBQDp8wqzQDdE8NJVbHX1vVtUfZNR+4XxOr6I83zC3clTmZ5TB/uF
 5pwFHSz7G+1ahA==
In-Reply-To: <8db2e1cd-553e-4082-a018-ec269592b69f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I believe this is still a problem, correct? I've been carrying the two 
patches in my tree for some weeks now -- otherwise the network adapter 
in my USB-C dock stops working randomly.

Anything I can do to get these merged?

With best wishes,
Tobias


