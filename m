Return-Path: <netdev+bounces-269983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMJeJJCAvWk4+gIAu9opvQ
	(envelope-from <netdev+bounces-269983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:14:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A42E2DE65D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C47D2326CE66
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA53BA22F;
	Fri, 20 Mar 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNduNeQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E53A7F4A
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025298; cv=pass; b=WYvk2nNki3Ws71VGM9JIHP8J1tBOWLgK3uC862L/6An/KhYHEGupdAkMvPfZNqCfXeZvecP2bR8SECX6Ah7Gr7YYVqqedHcyAN7akXyfTgW99bZMQbtJ4EIInUmKqhTBqRmGr0IB97oi93JckKrLISYqgk38i79BY6x8Y/K+FQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025298; c=relaxed/simple;
	bh=LXrVRQ8fQWgrceK4uzxtIg5tBruuwI4VQXrhJpNNIkk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YPvb4sJjLqLflDIcMyDfLv6VHlGK39ozr+bW7+L4Gk95chg6Nd++h6yVlx4g1NvchQdnmKkbDdKWrCGovU9o+OTKtjyDkePnEcXrziUxew3hyjx3FYugKP1cCMuCKb12/duGcLQS0sLb7a5ULoPbWqFsVlYaoKczRuecfG/sEx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNduNeQX; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-128b9b7e3edso782926c88.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 09:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774025296; cv=none;
        d=google.com; s=arc-20240605;
        b=QcFudDjUvJEY3SHqm4vJ2a18li6I3KafkznZ4zQFFraHn6hYiIOMiAhI1aMVb1YWN9
         XfFZJu4zmMVmW07COAL9TCueQEuRg5JYPDkfZlL+q5FrElulbstvCbGIi2KCc/E63ocO
         iC6fqDuFXJmbghR5dr73W236B8/doOiv8j+cDAPBu7DhBMTPtctFTLS6i97k7rzkqHDy
         IL5kXJldEBLKeN0K9jMxGc4tLFc7cmDQcfMW6e7Zv3wDUPYhmm8MvLxct0JKagOQWaur
         d9ReEv4aUTAaY2JeelcfafHNrcuHi2CWUW+U/6tSPtuty0yB5xzSzVuxEoVfo0bGl/4L
         JvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pgwmZT9IHM6934vKr9WC2TNz3ns+Qdpf2Q8D3gzT5iU=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=J6OcArbQhnSm51FqFMQ5bGJqdR/mep6EVdWurrXrEscFahmtgdsHS7BYjea0oSX8Ee
         RpQPiop/XC7KIMg/IkQvmkWm9NFBMSIpxH/rp2JG/UGle0eQSm0ix/ToaGNB3VqmouVq
         gfok6jCZnn5FgUh3WCII/ySdpNBJW5FwC1nrSSCzpQp/W/NkguCTwm2n3HqNqT9/ZF+u
         WTtc8RQ4x0RVfKkAvpVIh4YLefRiPUas/rrxHQ8kZDSBeUk4jvwJZiIzqz2w54sEMpEr
         BEAIzOgg79mHdB/thwKNOr8TCyibNVe6oAI9mk7SnqlSV7dvZ44/KN/1Az9ailEBUROV
         B0BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025296; x=1774630096; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pgwmZT9IHM6934vKr9WC2TNz3ns+Qdpf2Q8D3gzT5iU=;
        b=jNduNeQXPclqQRFH5cNwp6Nmrk7p4Si9TEPeajk8Id6Z8B4nDbGUMbFp9ILP8J5CS1
         2q0t9+yI9Yv1gIuaFBk7wVWkgC/+0WsG59Y75FfGrOVz8bx840Zx5kA6qtWBsAPXiwnS
         sp9xNtKdhhX1YIPnUxUhzQtnMr39jUf6bzPoimqFSzodPaeSFprG9JgftnxLUIpPawfq
         Sr4sq9Suk5QKKndR5e2MHhDoZytMOwCsZZGj5LEwjWjINO2RY2frPx7DvleiFIJGjHrk
         DSFrxuUzT73JsuPw8XyCUIa8WuNlAj9mgis5rlKki/x7qHbPb6ahDInU2JRZlsZ4OqPt
         EGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025296; x=1774630096;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgwmZT9IHM6934vKr9WC2TNz3ns+Qdpf2Q8D3gzT5iU=;
        b=LCTEOwZ5jm/gnEg3plnt5i+NRf98p7PWePIwF/YcZYUKmdXSYe7yObFx285Vq367j0
         D/3TxhtganMnBpv+Z3rBo3k5DFuXn7jZdzLuQ5upPobCnEcRb+Me9v3hFijgtWehzBPc
         oH4mGRzxcELTJN52BIQhwqAdbpqilVoVm1NEMywUhiwLL6kc4elrT20nywQNvdygTvSb
         IADjNy7HUdmnFLHvSILZg0SSfXDcUQHAK/HT7gII+pJrj0b7GsX32jiMDvWqnnkIhhsN
         HolLhOqhIJPnH1juzayBZbKRebjf7Ke6Xk0nS76eGxdaH8Qe/BPlxPPt/8zs4PHG1LSw
         sx1g==
X-Gm-Message-State: AOJu0YzGs+HF1VgyYi5WIpU+tuqBD6/siG0y4CS/zMCRLVa3QRUTz53f
	2LEvgjAuo1dKE/xul23QGbOxCqkmIvhxITjRH82u1oVHFMHwytO38qegm9dd8RwVK/h2lX76AkW
	03p5QUkup7l2uIsxYn+LtCJ4A+1Pn4DmRG/PT
X-Gm-Gg: ATEYQzzo3NSrHmX0Dr7KGgZb49iso7AqsADO7yQDWrPmZKJ3E7nIBibbx0CmwDLqPdX
	sVnDUDzq65sn+yhYikFL1LPc6iBmknKV+LD8f/m/PIkG7POwEXMarc+TcTjopC4zRcdGlnyX4Kh
	3wF6UyFT2eKZ+jZPzcFWZtJhLLwwM3obXonWP5ELfs5qxTlzd5OM6KPXQOd8ASzBAiy6K9PgsVU
	YPcDvfBoNpp05A6TiGOq4psBcoSepZHLg1xWXx6aXzF0sxeZAdqOmKwgnllcafpgbMhXBdq1EtX
	TVlbvadlInKdGRhdv/P6mlOoU7+tHz425gYEHfN4Gxt+PleGypeTLr28JRp5K+U2yJA=
X-Received: by 2002:a05:7022:621:b0:11a:641f:ba11 with SMTP id
 a92af1059eb24-12a726e6617mr1692620c88.29.1774025296395; Fri, 20 Mar 2026
 09:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Fri, 20 Mar 2026 17:48:05 +0100
X-Gm-Features: AaiRm50P17T-ROCPjmfVPmHzEP4Dtf8b9Vu9xUhwZQKLT3l72w-Gm4n1FS3iCzM
Message-ID: <CA+DkFDbcAqyj2miq7Y4nDfXXMef39WWhcKwowPKBeVH8b6pZVw@mail.gmail.com>
Subject: How to approach slow firmware loading process?
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbiel7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A42E2DE65D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello
I've been working on a 10G QXGMII Ethernet PHY bring-up and stumbled
upon a problem.
One of the first steps in the bring-up sequence is to load the PHY's firmware.
So the sequence is as follows:
1) For each port (phy_device) the PHY layer calls the driver's probe
function. In this function I check the port index number and calculate
phy base addr. Then I connect this phydev into the phy package using
devm_phy_package_join.
2) Then the PHY layer calls the config_init. In the config_init I use
phy_package_init_once to check whether the common init function has
already been called. If not then I call the common init function that
is responsible for broadcasting firmware to all ports of the PHY.
And this is the place where things get problematic. The thing is that
loading firmware takes ages... namely around 30 seconds, which results
in the boot process waiting for config_init to complete its execution.
The firmware size is around 300 kB. I've also done some tests using a
vendor userspace tool that also has fw loading capability and in
general it takes the same time.

I'm wondering how I should approach this? I obviously don't want to
block the boot process until the PHY's firmware is loaded. The one
thing that comes to my mind is to submit firmware loading to workqueue
and just return success from config_init. The problem is that in every
other function like read_status, config_aneg and so on I will have to
check whether or not the firmware has already been loaded and it's up
and running. Technically that is feasible however it sounds to me like
kind of a workaround, especially given the fact that if I decide to
submit firmware loading to workqueue I will have to return success
from config_init so I guess that phy layer in the kernel will assume
that everything works fine which in fact may not be true if e.g. fw
loading procedure fail or the phy will not bring up after the reset.

How would you approach this? I will be grateful  for some suggestions.

Best regards
Patryk

