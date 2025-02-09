Return-Path: <netdev+bounces-164512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F0A2E04E
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB7A7A29C4
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1D1D47C7;
	Sun,  9 Feb 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="AnVPbMsg"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7527136A
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739130542; cv=none; b=GtkzZ/y5NpEFjEJ9vBGN4M9D1EHM8JvrsvTnDNcs9cxyQn1LLuR+GOpcMN3B8kcPcF/akpWKfq73UttILAMd8S0pSBAYuXDDEMRIs5ko0jr/UzTVqmTqwy9NmVRZS70kKv+2s9J4NbeVv7xj6ttxoPOwqVvbSVN2d9JWgFSDUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739130542; c=relaxed/simple;
	bh=sB7X2elzaKzygKMTjg1J6HBySzLcFLP08u7Io8rsjSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVMITcjBpY2hZLtJUAGlQpPwAGFFa2yslScLXe/yKqkmKuWZX+heJQLj8uUVHZj0w2+X/HzR2ysgfvbKolC4DL9nTo7ZK9zuddyjsb0SOikg347Lj7Ze8gNLpWwS3rHdjySsDwBEUSPVBfwj6FCoLlccWq2LY+XscVO9ahZJZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=AnVPbMsg; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.144.30] (lfbn-ncy-1-721-166.w86-216.abo.wanadoo.fr [86.216.56.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id EF30E200E2B4;
	Sun,  9 Feb 2025 20:48:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be EF30E200E2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739130539;
	bh=j/s9WFHaRm44aCKz0S4Xl8fecNa8ZUz1vYeRut4ivSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AnVPbMsgYZszFtt8Pwua9+5LemBpOjLLoV2DeMV3X0v0FF2YesVIG7tFJRJ7D2/0U
	 pKgQOVYTS0QRRf5Iv8tgsP+14EPefjKnBNgKBlLF5keU1hdjFVECb7i4Jpe9Q2NEq3
	 oexyuOGzFTUrhoiTBOGAbUBIsfj9irSpaqj13z3MznjOydeI5CNmPreQJmmx0+taOF
	 pKLT8aoboVsISapURhVXoMa+azpXHfyeAwAqUD3fcL3jn+cF3J2EVBoaqEJsAwv5rq
	 wt8FkHSVZ5A9uZ3rTvVoqCXm0mOp2YEcs2jjMc5+F4rz4bsq6XI5cI0NAxudL/zG7r
	 H3S+zb2fYr/PA==
Message-ID: <1a1a5bf4-9b20-48bd-b4ef-b42efafcae49@uliege.be>
Date: Sun, 9 Feb 2025 20:48:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] several fixes for ioam6, rpl and seg6 lwtunnels
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20250209193840.20509-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250209193840.20509-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/25 20:38, Justin Iurman wrote:
> This patchset provides fixes to prevent loops in ioam6_iptunnel,
> rpl_iptunnel and seg6_iptunnel.
> 
> Justin Iurman (3):
>    net: ipv6: fix dst ref loops on input in lwtunnels
>    net: ipv6: fix lwtunnel loops in ioam6, rpl and seg6
>    net: ipv6: fix consecutive input and output transformation in
>      lwtunnels
> 
>   net/ipv6/ioam6_iptunnel.c |  6 ++---
>   net/ipv6/rpl_iptunnel.c   | 34 +++++++++++++++++++++--
>   net/ipv6/seg6_iptunnel.c  | 57 +++++++++++++++++++++++++++++++++------
>   3 files changed, 83 insertions(+), 14 deletions(-)
> 

@Jakub I'll send a net-next patch ASAP to provide rpl and seg6 "dummy" 
selftests to detect dst refleaks with kmemleak. Also for net-next, I'll 
re-apply the double allocation fix on top of this series.

