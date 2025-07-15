Return-Path: <netdev+bounces-207009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B8B0531F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0003A3F59
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15927280A;
	Tue, 15 Jul 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bb9CUVZn"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91A26F471;
	Tue, 15 Jul 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564249; cv=none; b=uMMxOZuatNSVMkpqvZTwmFWeWl5nOIXDcr4lfdUyiQ28I+2ZDbE+Fr3ymU9zHbVi+Sxg2L3/UAmEMu1B1C2Rq7M9DgHgFkOAB2pq+nRcHN3j5hRW197I96rECJptmRTlt1/1pqzTjwaIWG5FQN4m01uah2k6xVYsy1MZwBqTmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564249; c=relaxed/simple;
	bh=BXTbNsqHYtb78aC3SqWfGneQbTCjnctCyxMCBJ09N7k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rGPFnF2ESgIiR1mslHUN+mq1AU1v/wWEoO1nMKMsf75kGAA/SXgfH8MMYQyd1pCmH6fyFIFNKLeqAeEElyussrhcUmn+1+YUH3dgZ5IUfa3XJd4WW4UOcETWVuHzNJi8I+D3ezWI0E9shokqDPr1iWCeucLWAyAfsdTsdA7evsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bb9CUVZn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752564099;
	bh=6ljyNSsJ9lRiZijcfuWG6pzCp0qBpPAPmbp2XKWMBlU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=bb9CUVZn86ENM63zABfZN3lTUs8nLzthyk69brgQUipicO1k0HKkgQqDx22yeETtB
	 SfCvIv8iPfXQnuBIIaKimfqUKt2pwCW41eccBJRVYZTi1yCl2FjWk2GH+uUvY60f77
	 1Y8E+gzigLeamygcbYJuQhGBFO0epkFMHkhnLiQ0=
X-QQ-mid: zesmtpip4t1752564070t2d6fe610
X-QQ-Originating-IP: 02fN+bCDAMO8qWCbbIp+weQD8yas8dWFM1orO/k1MLY=
Received: from [IPV6:2408:8670:2e0:408::113:10 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 15:21:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7763901825682944429
EX-QQ-RecipientCnt: 11
Message-ID: <B4FF81C421E3D77D+65165cda-6331-4a05-b7b5-b7173cfdbd55@uniontech.com>
Date: Tue, 15 Jul 2025 15:21:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kuniyu@amazon.com
Cc: davem@davemloft.net, dsahern@kernel.org, duanmuquan@baidu.com,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, jiazhenyuan@uniontech.com,
 goutongchen@uniontech.com
Reply-To: 20230619175824.50385-1-kuniyu@amazon.com
From: Gou Hao <gouhao@uniontech.com>
Subject: Re: [PATCH v2] tcp: fix connection reset due to tw hashdance race.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NTHY/YkN8c+xGEVxJtBoRp+Rh2MzaENRXsVS4OUIl4yIJAA0PwjIPztf
	kcEyXcoJWYEXP19kMe4BeM7M4MOCOklYysHqIzaEb6gZ0aPPu5WCsMmb/uhhUjk+v67KcmL
	ilbYttFo/o3RimbcaSPSLGayDU+fu+qEb0rP9n9Z4y7+jQU3qe22JvdrohgIE8tgr57EVUg
	ahkO2XyMcAFFOAXXo0zZwgbFTtDnCpHOK6uGiG2DNwvbhAaLEPMcut7H/c0A+lhCCxD9xX9
	PJF4Rgg33W02ABCKyXj9s0tHvD5qmSqRqCd1j3XAh26sitVHTBYLkNHqDp68p7KnOQXKbOX
	wgfoIAgmWDtBk4EH5gVr3hCY/X0dKngQrjpbLU0QUGDjcc+JUHI7WxUQ0HhqiS/DKt3u8xh
	wKWxG4VWII3M4vt8xxD4CCuucQPb/eoItaZdrD5ctlZdZKg6JioqpRcLf3IHzSRvi/DzeK5
	mvmZuqKZUZesr5WkvpWxFK/URcw2GXbpvF+NoNVzCm9oucTtbjlz4v8khjbKxiCW78Rb54N
	uk9j50v/09O5oY8ZLy1n8JPv6jxu/WNcIoiBD9YcGZdwDMEecI4idqBxwDFFuV2dYAguzO4
	ZLFFniKAsnST1d1ckJycfhNXJu/1KcYgFSV6FBeB2Vw35P+t929kky8aIbHcKo/yPWjPATk
	tftQz/9TYYyIfXH4JHEs77R+T28dwqorGx/1ktUrP/JdrxV7kF5QX7TQduWXlyxiBWztjD4
	4AJTyswcjp2sEemKd30s+fJOqVC7F+IFR7QoHnhboOuWT2DDh2yzRuCUujFqIfu016fo+s+
	a+f20OZ/COY7g0XYdiCw6RVeLMDZfRobjsXOVPCKf3ERWxWEQodR0AKpeFcsZyujdAQnwI9
	s00clh3o2UiA26pRbobKR6gVgSyQqE+LAbkv9pMjQfsmxFzTUrTUbKzFCIutQfwEEQ0dHS1
	/34A9iy3Eud6asg8Zp1S/MA6ju4MR6ZvFNoyxeoeWSSnvVftRzlVrDNEq
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Could you please tell me how this issue was ultimately resolved? I don't 
see any related patches in mainline.

We encountered the same situation in our actual business: due to lookup 
failure, the client received RST packets.

As follows:

    CPU 0                                       CPU 1
    -----                                             -----
tcp_v4_rcv()                      syn_recv_sock()
                                             inet_ehash_insert()
                                             -> 
sk_nulls_del_node_init_rcu(osk)
__inet_lookup_established()
                                             -> 
__sk_nulls_add_node_rcu(sk, list)


--

thanks,

Gou Hao

