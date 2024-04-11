Return-Path: <netdev+bounces-87185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A38C8A2051
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 22:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD91C21BE2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BC725575;
	Thu, 11 Apr 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b="UXbrraKz"
X-Original-To: netdev@vger.kernel.org
Received: from bobcat.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A11863F
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.58.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867822; cv=none; b=Px5vO9IZsP+imTkSEZJ1QVlgfex29HH2nLY3DrVRlUudpyQ5sULGCxXkvWxEg0pOPoaVxPDUU1RabPG1Sl67xlcaSNk/g8vw1NqGha8kQWLlVxbtxvCZmaI4ltW7m9hCLb7xv+NnOPOMUwdGV9UlYzuA35/1vUX8vYcJD1rBftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867822; c=relaxed/simple;
	bh=gDADatflrjmCh/O4yH6EZDoOj9fn0cVSbC5L1vnM84Y=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=M1HdtJjM6Burbs0M4owaM0Btaf2xndGkI3g9wCU2BUUWyP5WEeg7+CKA/wv0W1b6qSV1DPkvGNlHjFS8XkyJ21GuYOHg78nYOlYM7tN86gMolPmDN1o0sIrTUbEs4ApIFEvVIc8vISKhLQ4/fbu3OOlJnuFCPwMyWflKsV+suNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rjmcmahon.com; spf=pass smtp.mailfrom=rjmcmahon.com; dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b=UXbrraKz; arc=none smtp.client-ip=45.33.58.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rjmcmahon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjmcmahon.com
Received: from mail.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	by bobcat.rjmcmahon.com (Postfix) with ESMTPA id E7EEF1B27D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 13:28:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 bobcat.rjmcmahon.com E7EEF1B27D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmcmahon.com;
	s=bobcat; t=1712867337;
	bh=8ORLJqqiahWmq7VLaRVIl6jJGGjCqc/+jaxtsZAzKLI=;
	h=Date:From:To:Subject:From;
	b=UXbrraKzfBdUSmSpCF3DQzFeUm6M5ltFR62ojSBef0j1bPB+A/Mbyor2z1LIa0EQR
	 ltn74SXFkGh01SR0S3DgfI/TC8W7Rup79FhtSdHmzCOrFvcH6hiNn/eEBBBZBCRYJS
	 37GWeypkTogTrsUZJti9GoaclKYqb2FBSOMvplUA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Apr 2024 13:28:57 -0700
From: rjmcmahon <rjmcmahon@rjmcmahon.com>
To: netdev@vger.kernel.org
Subject: iperf 2.2.0 release
Message-ID: <dad9030c7a57d93220503ef4411af89b@rjmcmahon.com>
X-Sender: rjmcmahon@rjmcmahon.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

iperf 2.2.0 has been released. Lots of features & bug fixes and 
hopefully on a few regressions. Big focus around latency and buffer 
depths, .e.g support for inflight on the client and in progress (per 
Little's Law) on the server.

See sourceforge for the README and more: 
https://sourceforge.net/projects/iperf2/

Man page is here: https://iperf2.sourceforge.io/iperf-manpage.html

Example use over a Wi-Fi link with -e (or --enhanced) & --trip-times 
follows. Note: Clock sync needs to be done ahead of using --trip-times, 
e.g. with pulse per second or PTP (IEEE-1588).

Feel free to email me with any issues or comments.


[root@ctrl1fc35 iperf-2.2.0]# iperf -c 192.168.1.232 -i 1 -e 
--trip-times
------------------------------------------------------------
Client connecting to 192.168.1.232, TCP port 5001 with pid 2808134 (1/0 
flows/load)
Write buffer size: 131072 Byte
TCP congestion control using reno
TOS defaults to 0x0 (dscp=0,ecn=0) (Nagle on)
TCP window size: 16.0 KByte (default)
Event based writes (pending queue watermark at 16384 bytes)
------------------------------------------------------------
[  1] local 192.168.1.15%enp2s0 port 44778 connected with 192.168.1.232 
port 5001 (prefetch=16384) (trip-times) (sock=3) 
(icwnd/mss/irtt=14/1448/6300) (ct=6.37 ms) on 2024-04-11 11:47:11.432 
(PDT)
[ ID] Interval        Transfer    Bandwidth       Write/Err  Rtry     
InF(pkts)/Cwnd(pkts)/RTT(var)        NetPwr
[  1] 0.00-1.00 sec   197 MBytes  1.65 Gbits/sec  1574/0         0      
658K(466)/5664K(4006)/7632(1329) us  27032
[  1] 1.00-2.00 sec   209 MBytes  1.76 Gbits/sec  1674/0         0      
702K(497)/5664K(4006)/7907(2023) us  27749
[  1] 2.00-3.00 sec   208 MBytes  1.74 Gbits/sec  1663/0         0     
1924K(1361)/5664K(4006)/7689(1454) us  28349
[  1] 3.00-4.00 sec   204 MBytes  1.71 Gbits/sec  1630/0         0      
767K(543)/5664K(4006)/9323(3084) us  22916
[  1] 4.00-5.00 sec   209 MBytes  1.75 Gbits/sec  1672/0         0     
2306K(1631)/5664K(4006)/7586(1930) us  28889
[  1] 5.00-6.00 sec   203 MBytes  1.71 Gbits/sec  1627/0         0      
644K(456)/5664K(4006)/7498(2578) us  28441
[  1] 6.00-7.00 sec   205 MBytes  1.72 Gbits/sec  1639/0         0      
453K(321)/5664K(4006)/8996(1837) us  23880
[  1] 7.00-8.00 sec   205 MBytes  1.72 Gbits/sec  1642/0         0     
1214K(859)/5664K(4006)/9549(2058) us  22539
[  1] 8.00-9.00 sec   206 MBytes  1.72 Gbits/sec  1645/0         0      
554K(392)/5664K(4006)/7606(1142) us  28348
[  1] 9.00-10.00 sec   208 MBytes  1.74 Gbits/sec  1663/0         0      
390K(276)/5664K(4006)/9105(484) us  23940
[  1] 0.00-10.02 sec  2.01 GBytes  1.72 Gbits/sec  16430/0         0     
    0K(0)/5664K(4006)/10840(3545) us  19825

[root@fedora iperf-2.2.0]# iperf -s -i 1 -e -B 192.168.1.232%eth1
------------------------------------------------------------
Server listening on TCP port 5001 with pid 1012228
Binding to local address 192.168.1.232 and iface eth1
Read buffer size:  128 KByte (Dist bin width=16.0 KByte)
TCP congestion control default reno
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  1] local 192.168.1.232%eth1 port 5001 connected with 192.168.1.15 
port 44778 (trip-times) (sock=4) (peer 2.2.0) 
(icwnd/mss/irtt=14/1448/6008) on 2024-04-11 11:47:11.443 (PDT)
[ ID] Interval        Transfer    Bandwidth    Burst Latency 
avg/min/max/stdev (cnt/size) inP NetPwr  Reads=Dist
[  1] 0.00-1.00 sec   196 MBytes  1.65 Gbits/sec  
5.943/1.431/23.584/2.449 ms (1571/131125) 1.18 MByte 34661  
3190=741:212:241:640:334:152:96:774
[  1] 1.00-2.00 sec   208 MBytes  1.74 Gbits/sec  
5.846/1.520/13.633/2.320 ms (1664/131063) 1.22 MByte 37309  
3400=792:233:259:685:337:168:129:797
[  1] 2.00-3.00 sec   208 MBytes  1.74 Gbits/sec  
5.812/1.644/12.749/2.292 ms (1662/131055) 1.21 MByte 37476  
3442=816:236:272:686:347:176:125:784
[  1] 3.00-4.00 sec   204 MBytes  1.71 Gbits/sec  
6.326/1.475/15.828/2.552 ms (1634/131054) 1.30 MByte 33854  
3491=841:234:263:829:363:134:106:721
[  1] 4.00-5.00 sec   209 MBytes  1.75 Gbits/sec  
5.744/1.398/14.738/2.371 ms (1669/131075) 1.19 MByte 38089  
3400=748:279:266:657:353:169:143:785
[  1] 5.00-6.00 sec   204 MBytes  1.71 Gbits/sec  
6.023/1.469/16.495/2.461 ms (1634/131129) 1.23 MByte 35573  
3280=734:228:226:662:335:176:128:791
[  1] 6.00-7.00 sec   204 MBytes  1.71 Gbits/sec  
5.840/1.506/14.574/2.345 ms (1635/131013) 1.19 MByte 36677  
3292=731:244:249:647:338:162:127:794
[  1] 7.00-8.00 sec   205 MBytes  1.72 Gbits/sec  
5.862/1.459/14.374/2.413 ms (1637/131059) 1.20 MByte 36600  
3303=724:245:274:623:349:171:135:782
[  1] 8.00-9.00 sec   207 MBytes  1.73 Gbits/sec  
5.747/1.531/13.705/2.322 ms (1653/131127) 1.19 MByte 37718  
3281=690:260:263:599:349:171:138:811
[  1] 9.00-10.00 sec   208 MBytes  1.75 Gbits/sec  
5.926/1.300/17.368/2.525 ms (1665/131019) 1.24 MByte 36810  
3263=669:259:253:585:360:171:145:821
[  1] 0.00-10.01 sec  2.01 GBytes  1.72 Gbits/sec  
5.907/1.300/23.584/2.411 ms (16430/131072)  477 KByte 36434  
33354=7488:2430:2569:6614:3466:1653:1272:7862

Bob

