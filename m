Return-Path: <netdev+bounces-146169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912169D22C2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554252817E7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017E1AA1F8;
	Tue, 19 Nov 2024 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dHFOnqF4"
X-Original-To: netdev@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1914AD24;
	Tue, 19 Nov 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009723; cv=none; b=XWYhx7s/DQpO4Kl5KrKjfaz6GRPdwVmrYeGlFPwhS2o8t0ufkfgCK0FZsz3fLLUyqzehHKgerKOMAgd1Pqk0cPCtCVI3aTxifAHybGzD91cZ3H+tOEh85DsM/e3JVYn28t3GrTITpQQMRj/ixnlxOIW9+BJl0t2NzZBlokWVjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009723; c=relaxed/simple;
	bh=5PZ6m2GEAyNN96EHseKtAqIwIUc/JC1dE0eYPR9GsQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCVOeosCHhH63jwdgul+hpFVeR22sgBUbbl/mGymHohY5hiZqKfX3EtBGaoShdvGk13Cg1XXpcYfurvKyi/NOTWwrv+VcslEEcyLxl0lBfdMN0rpyjNU/VTZJfHkijaR2A8cVzM/iS5KUwgwFRoLfaTf9g2MZ0RfLuMizNKVHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dHFOnqF4; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3ca8:0:640:a920:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 5AE7161487;
	Tue, 19 Nov 2024 12:42:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XgNicYTOhmI0-CoY1FNFo;
	Tue, 19 Nov 2024 12:42:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732009356; bh=katyZrPhokp9l9mQeL64lcMdoGx8Uo2/Iourd02Wj30=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=dHFOnqF4OhEhJpTGKzdMMZISQNrVNKEM+Cbvna65QDkTpp9YllviMU9dTTJIpy9Lz
	 +Cu+Ehc3twqXFolA8WhrbrYAyNxLPv9OxvLMACOTZKcJUpisQTgr1mrjETeVo77gTt
	 SEm7G4N9bu+HzUJgakpI6MLrnx5AJoWSGFKkoL8Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <610a9e2a-aa6b-4a2a-ac5d-3ea597b16430@yandex.ru>
Date: Tue, 19 Nov 2024 12:42:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: fix group permission check
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, agx@sigxcpu.org, jdike@linux.intel.com,
 Guido Guenther <agx@sigxcpu.org>
References: <20241117090514.9386-1-stsp2@yandex.ru>
 <673a05f83211d_11eccf2940@willemb.c.googlers.com.notmuch>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <673a05f83211d_11eccf2940@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

17.11.2024 18:04, Willem de Bruijn пишет:
> Stas Sergeev wrote:
>> Currently tun checks the group permission even if the user have matched.
>> Besides going against the usual permission semantic, this has a
>> very interesting implication: if the tun group is not among the
>> supplementary groups of the tun user, then effectively no one can
>> access the tun device. CAP_SYS_ADMIN still can, but its the same as
>> not setting the tun ownership.
>>
>> This patch relaxes the group checking so that either the user match
>> or the group match is enough. This avoids the situation when no one
>> can access the device even though the ownership is properly set.
>>
>> Also I simplified the logic by removing the redundant inversions:
>> tun_not_capable() --> !tun_capable()
>>
>> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> This behavior goes back through many patches to commit 8c644623fe7e:
>
>      [NET]: Allow group ownership of TUN/TAP devices.
>
>      Introduce a new syscall TUNSETGROUP for group ownership setting of tap
>      devices. The user now is allowed to send packages if either his euid or
>      his egid matches the one specified via tunctl (via -u or -g
>      respecitvely). If both, gid and uid, are set via tunctl, both have to
>      match.
>
> The choice evidently was on purpose. Even if indeed non-standard.

So what would you suggest?
Added Guido Guenther <agx@sigxcpu.org> to CC
for an opinion.
The main problem here is that by
setting user and group properly, you
end up with device inaccessible by
anyone, unless the user belongs to
the tun group. I don't think someone
wants to set up inaccessible devices,
so this property doesn't seem useful.
OTOH if the user does have that group
in his list, then, AFAICT, adding such
group to tun changes nothing: neither
limits nor extends the scope.
If you had group already set and you
set also user, then you limit the scope,
but its the same as just setting user alone.
So I really can't think of any valid usage
scenario of setting both tun user and tun
group.


