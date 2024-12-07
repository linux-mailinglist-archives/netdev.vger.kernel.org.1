Return-Path: <netdev+bounces-149902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072C69E810B
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6BB281A7C
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03C82CCC0;
	Sat,  7 Dec 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="zSatrhc0"
X-Original-To: netdev@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0673FF1;
	Sat,  7 Dec 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733589971; cv=none; b=msiLApEV2MzjFHduqIs2MOUqvAYtwaEXglHujcuYIDzlBl5VrCOuMUs6TOZvo+xm7xw2ed0abJUvRZX0oxtFN+hej2xEbjBL94aDQJ+FzoYPTqG4SKIlFcUXtddLa0yM+jZ05+UR2eJ5sTAovoaE5wFCZqNgS8/TOh3bbxinQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733589971; c=relaxed/simple;
	bh=vjo3piGQdxjqRK8NxIaEdi3jtvE1yBamRNmmGNfgHJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBaX8G4uGjEgulQ6sbk8GtHYF2uSYkP6lz6YkaFWpqDEYvCDrFxlDbosMEDoT1QDbKEr19v3dnRlrDThPQKAnc1M4H/Mj7jzjAISmv0tEmPVzg6tmH2mZyjtCWQudlFD0mHls04LpwZ+IaRwC18/+idFENGGmoINdHgaj4Vbdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=zSatrhc0; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Y5DLV4sjwz20P9;
	Sat,  7 Dec 2024 17:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1733589442; bh=YXarENHHWjbfLniaZIIE4fO22MS5mtbMTeDyQtvYSUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From:To:CC:
	 Subject;
	b=zSatrhc0tBwAC6cWCA/9yvnyX2U501gd1oTUKZOUaFEhpaZAnPccf/S3yioconMZt
	 OS4lMRrVEh4A5k3AgmK/Lg+2IrgR45pjuWVz9aMdfQYBO9uvXA4DyBImjbWWdZS3T7
	 VXgcZruuISeXgES7IHCn64NpBQCUEvspdRa0U0klPFkZahUDgG42wISUvGigID3jic
	 nlrrvN+k7FnH4bj1V17n8fwdnmWk8g+Rl5j482yeL1+L03weEhfWZoAxa/GS3rCr8V
	 AdRU2xXDWz+zxDQVxVH/O1g37/mnnveZaZrNB8R49/W0ntEe64IGVZ4cPOcZH508IE
	 VX0qTnflWG+rQ==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:d5:72f:de01:9dee:185f:b8b5:8714
Received: from [IPV6:2003:d5:72f:de01:9dee:185f:b8b5:8714] (p200300d5072fde019dee185fb8b58714.dip0.t-ipconnect.de [IPv6:2003:d5:72f:de01:9dee:185f:b8b5:8714])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18vcxNlkZ3YdYeS2ZUx20eBB+l4dsqbtwA=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Y5DLS0Y5cz20Mr;
	Sat,  7 Dec 2024 17:37:19 +0100 (CET)
Message-ID: <b4f59f1c-b368-49ae-a0c4-cf6bf071c693@fau.de>
Date: Sat, 7 Dec 2024 17:37:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/sched: netem: account for backlog updates from
 child qdisc
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241202191312.3d3c8097@kernel.org>
 <20241204122929.3492005-1-martin.ottens@fau.de>
 <CAM0EoMnTTQ-BtS0EBqB-5yNAAmvk9r67oX7n7S0Ywhc23s49EQ@mail.gmail.com>
Content-Language: de-DE
From: Martin Ottens <martin.ottens@fau.de>
In-Reply-To: <CAM0EoMnTTQ-BtS0EBqB-5yNAAmvk9r67oX7n7S0Ywhc23s49EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.12.24 13:40, Jamal Hadi Salim wrote:
> Would be nice to see the before and after (your change) output of the
> stats to illustrate

Setup is as described in my patch. I used a larger limit of 
1000 for netem so that the overshoot of the qlen becomes more 
visible. Kernel is from the current net-next tree (the patch to 
sch_tbf referenced in my patch is already applied (1596a135e318)).


TCP before the fix (qlen is 1150p, exceeding the maximum of 1000p, 
netem qdisc becomes "locked" and stops accepting packets):

qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
 Sent 2760196 bytes 1843 pkt (dropped 389, overlimits 0 requeues 0)
 backlog 4294560030b 1150p requeues 0
qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
 Sent 2760196 bytes 1843 pkt (dropped 327, overlimits 7356 requeues 0)
 backlog 0b 0p requeues 0

UDP (iperf3 sends 50Mbit/s) before the fix, no issues here:

qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
 Sent 71917940 bytes 48286 pkt (dropped 2415, overlimits 0 requeues 0)
 backlog 643680b 432p requeues 0
qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
 Sent 71917940 bytes 48286 pkt (dropped 2415, overlimits 341057 requeues 0)
 backlog 311410b 209p requeues 0

TCP after the fix (UDP is not affected by the fix):

qdisc netem 1: root refcnt 2 limit 1000 delay 100ms
 Sent 94859934 bytes 62676 pkt (dropped 15, overlimits 0 requeues 0)
 backlog 573806b 130p requeues 0
qdisc tbf 10: parent 1:1 rate 50Mbit burst 1537b lat 50ms
 Sent 94859934 bytes 62676 pkt (dropped 324, overlimits 248442 requeues 0)
 backlog 4542b 3p requeues 0

> Your fix seems reasonable but I am curious: does this only happen with
> TCP? If yes, perhaps the
> GSO handling maybe contributing?
> Can you run iperf with udp and see if the issue shows up again? Or
> ping -f with size 1024.

I was only able to reproduce this behavior with tbf and it happens 
only when GSO packets are segmented inside the tbf child qdisc. As 
shown above, UDP is therefore not affected. The behavior also occurs 
if this configuration is used on the "outgoing" interface of a system 
that just forwards packets between two networks and GRO is enabled on 
the "incoming" interface.

