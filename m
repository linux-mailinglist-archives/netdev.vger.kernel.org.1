Return-Path: <netdev+bounces-202928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE37AEFBA8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911B516FD70
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A06B2797BE;
	Tue,  1 Jul 2025 14:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC6279794;
	Tue,  1 Jul 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378718; cv=none; b=jhIEtOy6OoAbwRbohZZO1018wQjmLEqM4yXsyjCONSdQPi7nQS3OYOEI3aAKJnfUYiNMAYvDP8LBMh+mUSv4nuI1MNB0U4jRtuadEHZimOGLnDnylOsOX07EDlkSaGRC2zEZY3ijdtF4/f44HT/3/sqopcYqfxyGGiUEYHTh2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378718; c=relaxed/simple;
	bh=Y9pAIOixd6orCBEIX66d20TJ1MUVJfSdbmAuxAB3020=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXro3W8eUmlXof7i+GURCJR2x8NzcyGdWdumXtAdMcucmUw7SbKSY99PVfqs2R2+31o+UBB/pvuf924jGtqDsfQbR7F5CXtdpOXV8RHzqeI1jaBUQTNueey3IhpoZDEbteVsrU3JGH4XrhYSmhM/qhLv1UWKMD0NAhV8xEsSN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AA73546ECA;
	Tue,  1 Jul 2025 16:05:14 +0200 (CEST)
Date: Tue, 1 Jul 2025 16:05:14 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: add `do_forwarding` sysctl to enable per-interface
 forwarding
Message-ID: <26eakfopegf7medtwme5gecxoxfgttp5ed2eqahqmnzc54ffwf@po2minrxkxka>
Mail-Followup-To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625142607.828873-1-g.goller@proxmox.com>
 <f674f8ac-8c4a-4c1c-9704-31a3116b56d6@6wind.com>
 <hx3lbafvwebj7u7eqh4zz72gu6r7y6dn2il7vepylecvvrkeeh@hybyi2oizwuj>
 <99780599-91e8-4fc7-98be-1afa849e7db2@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99780599-91e8-4fc7-98be-1afa849e7db2@6wind.com>
User-Agent: NeoMutt/20241002-35-39f9a6

On 30.06.2025 16:53, Nicolas Dichtel wrote:
>Le 27/06/2025 à 16:47, Gabriel Goller a écrit :
>[snip]
>>
>> Sent a new patch just now, thanks for reviewing!
>>
>FWIW, I didn't see any new patch from you.

It's out now, forgot to actually send it -_-

>Regards,
>Nicolas


