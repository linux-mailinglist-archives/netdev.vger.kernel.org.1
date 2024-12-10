Return-Path: <netdev+bounces-150817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527949EBA9D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7748B188508F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DAA226861;
	Tue, 10 Dec 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="gueOzaKY"
X-Original-To: netdev@vger.kernel.org
Received: from mx04lb.world4you.com (mx04lb.world4you.com [81.19.149.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895808633A
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861271; cv=none; b=HxK0gUNyDTIs2mOpJS9YNKSAa6McvuuyEjqk1u9oapOl8MU7cIxlBPq0fq/laMi5aoQXLJxrZE3Sqn1MaDO55aKeUq/rqeyyE/NXGsJMbjwyyzSr2/1/NcrUk/boxLVyk8eiS0PpU5FQtUyyRKOsODVx10Y+EIRzzEpjoZzNM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861271; c=relaxed/simple;
	bh=F7woYvry3+aLKVoNl+4k/qBjmXrAxbYidJQZz+WxI0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPPyPjjCriuDB3lk5s2+Vz5PCkqGS5GK4lJzx/NNJ+tk8pQbImDw0Ue6qkO+WHmMAN6sqnjdMgUYQUn7sGnx+Z2yXebTKs9FV93w4SBLPoCk3Bf+j6tcHND02Ptrt05SnN+u79ep9fl8WYyADnDG2CFMOZ0BkpDcTOotU+PSsw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=gueOzaKY; arc=none smtp.client-ip=81.19.149.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lnZE1dOWpl9EX2OVEJeaZEwlAEsYcjlUnXot6Nbygj0=; b=gueOzaKYPSxZbXKPTtt9JJN0zl
	MHmwoEA5Jv1iIqfTmH3NXKOgq7y/SNA/KpjHPQA4QqRFr9i1lWxJ9/JZIRXZnaZZxskwkKQzPcSAy
	e2TYKkGv8FX50pf8P7EkowtkgOyx7r4j2pyzdpj8RgQ4XDJ7eXsg8KjoqHEKH63lxmCw=;
Received: from [88.117.62.55] (helo=[10.0.0.160])
	by mx04lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tL6Mg-000000008LO-1pXC;
	Tue, 10 Dec 2024 20:57:51 +0100
Message-ID: <71bdcb46-83c3-496e-861f-cc0841fb26e3@engleder-embedded.com>
Date: Tue, 10 Dec 2024 20:57:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] e1000e: Fix real-time
 violations on link up
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Gerhard Engleder <eg@keba.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20241210152708.GA3241347@bhelgaas>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20241210152708.GA3241347@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 10.12.24 16:27, Bjorn Helgaas wrote:
> On Sun, Dec 08, 2024 at 07:49:50PM +0100, Gerhard Engleder wrote:
>> Link down and up triggers update of MTA table. This update executes many
>> PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
>> are flushed. As a result, DMA transfers of other targets suffer from delay
>> in the range of 50us. This results in timing violations on real-time
>> systems during link down and up of e1000e.
> 
> These look like PCIe memory writes (not config or I/O writes), which
> are posted and do not require Completions.  Generally devices should
> not delay acceptance of posted requests for more than 10us (PCIe r6.0,
> sec 2.3.1).
> 
> Since you mention DMA to/from other targets, maybe there's some kind
> of fairness issue in the interconnect, which would suggest a
> platform-specific issue that could happen with devices other than
> e1000e.
> 
> I think it would be useful to get to the root cause of this, or at
> least mention the interconnect design where you saw the problem in
> case somebody trips over this issue with other devices.

Getting the root cause would be interesting, but this problem happens on
a rather ancient platform: an Intel i3-2310E Ivy Bridge CPU launched in
2011 (which still does its job as robot controller). Intel support does
not answer questions for such old platforms. Even for other timing
issues on the interconnect the Intel support was limited. I will mention
the CPU more explicitly as the platform with this issue.

> The PCIe spec does have an implementation note that says drivers might
> need to restrict the programming model as you do here for designs that
> can't process posted requests fast enough.  If that's the case for
> e1000e, I would ask Intel whether other related devices might also be
> affected.

Even for newer CPUs the Intel support has already ended and this CPU is
not sold by Intel anymore. So I won't get an answer. But our experience
is that limiting the number of posted writes always make sense at least
for real-time. Even for our own FPGA based PCIe target, which is able to
consume posted writes at full speed, we limit the number of posted
writes to reduce negative effects on real-time. This experience was made
with multiple Intel platforms.

Gerhard

