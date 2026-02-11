Return-Path: <netdev+bounces-258203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAY/I14hjGm2hgAAu9opvQ
	(envelope-from <netdev+bounces-258203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 07:27:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B11219B4
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 07:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A81E30143D6
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86313148A3;
	Wed, 11 Feb 2026 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hefbM+WN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720BF2DD5EF
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770791259; cv=pass; b=jrqg0MoZzYBTW1UFLLfgPNBXGqFtNYtE2KODCL5UAHpIKKsfhQoDrz3vjUi+s1IkncOG4Zbay+K+I+zehPSCJUOo4N0BlfwBNzxigslepPgpYRGy2s3n7Oq+bCidf18pNy5LL1ofA9WzI2o/Xaewang4kjrcZgBQiR8FeEHlzKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770791259; c=relaxed/simple;
	bh=Dn5hHLsNjYLkYjtqyu4iag9EjXYfFfp6HgaMiWI54j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqoR0eidZtBryrd91DLfgiUUxcw4+rVjLin8WyfNamiVKWennm8E81TyI20w3CpbWjikSMBs3F65oS7kdoJe5rArjbGYbyBF/B5U14XXfXK8i2qFaNAyO7cWd15xpSyHtVDicnrvPo49ua0PCki/omQJBUwmMHGUjyhdxZw+Fcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hefbM+WN; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b872cfd35cfso78078666b.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 22:27:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770791257; cv=none;
        d=google.com; s=arc-20240605;
        b=B2pyFYn69p7rydNts/OkPXslmGilAxNUnH9Rfx6BcZuTPHSPbIbyh7Vc8B40kEmHMZ
         5oJSoHUAC5O69ZDCCbd0ycKO+85EwAOOiPeHfrO39HZPj78TAPBr4VsHfEpYQOxtlWVQ
         ylN+JvyXbxtKU7CICYvFubppD9vQ6x35y1JMmU4BNnlaciBt0/GRmLOngPlXKj+GlbRy
         lmVOObgJ4f6Pt8BJFuVk4FybcxbscMdjy/yP4uYigfk0opkTy5u89xOMtTizkoigKTp+
         kpqbbaDX/M03ow1SwCR1Hdsdla3xTIiQq49pavgSMNH6CQUy/eWmiImAQIAOzkmCpwUQ
         FUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dn5hHLsNjYLkYjtqyu4iag9EjXYfFfp6HgaMiWI54j8=;
        fh=oefpkfQV7ZHrWYoKLmQtobjbRpGhzH2GdTuLpklMcl8=;
        b=EgpK7QCrWmNDv7Z8A4/n5kQmbReB1SlHfkCs1NeDvnRtL6s5ch72jaUIJp7FdoW1W5
         n8K5PIJfjYqlurC6Rt7HQHL3HRF0gdi8sR6gOD91gqYOA4ono0QhCrw99WmRiVi1FUuY
         xU8H+cSwl0xNO35GOYkdtmvY+f2bXckNX/ZFVPa2Q/snSUdPp8FszGhr48Uc58Et0RjW
         mVLZUxb1a1UaFVlcmG1Pm5rILh6I3wqK0GHnfKIpnXkNQ4hzZOokAXTZClaNp6qov4q6
         AxDC6++vmU08fLP9scWAGHcKPAjcGpNHNjEbphLD2y/eVjvHEmEnw51fv7Vx0CflYqsr
         ejoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770791257; x=1771396057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn5hHLsNjYLkYjtqyu4iag9EjXYfFfp6HgaMiWI54j8=;
        b=hefbM+WNutBoj1TqNNAbAxc1SWtkWM3Pc/zlzRk2vk3hZu8BET2MA4TLz83UonF7EG
         PBBgq5JlwNa0DBmgebkuDVI8Mqv3O2VMPnaxNd7VbOKjMgjdtupbXqHfeOQoawXgXbd9
         xMJ36x+VyPqPC1FxkYfxMFdeYVfCqb9U+6g0a2fKRuo3IxX7yHdQJWIzx4Gy1QfB3opQ
         hkE5Swk9jvGL2yBm1bjimsoCQsYiz/joaYTCMBRvipOOoFPCcZDyaSnFBMNvw8Uq7hJi
         GKGUSA3dt8rtpwGqFlCdRW4F9/SGVRSLidYbvzCetTLbmFbAiCfzKJXnaak5W/P4baHb
         DkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770791257; x=1771396057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dn5hHLsNjYLkYjtqyu4iag9EjXYfFfp6HgaMiWI54j8=;
        b=C3qmp13MS7ET0SWHWIpb6YGYLhyfpmp06nKrFfwcKxMJxB0CyQl8Q+nwyiDWggZ1XF
         +l1LVzGyULw69GM1ZosZQ27tEyPpT2pGeoBidIUYuxajElpI5lCHJnKF8u9irnzqEBtH
         ZFmEYi4wqci8+N/nZ7iYLi4pegqdYqPJNQp1jiw3x+rZo+Ly38NLMUipsmfYk7WyoWYR
         SEDxygiz1jXZKTqhpHZ/YqjBW6/Lw7cN2qweyGGn6JWmqV2jiTee7u/7Jhb520pPDQth
         EHHnulmO5zFgpUyGr4pSeitKDqqAOEdUbyQB2NnMm5VbO5Py8eic6vWOKRX+a26nlxFu
         P76w==
X-Forwarded-Encrypted: i=1; AJvYcCXZMai5WPHEhmZBAScNZ/CVLvv5zbCLvhfrRtCMxrIQE0FeN+ifLN9Ih7FrWRSxrB2mupu2IaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4di6hRqI5OreYAi+vICn0/DZ4lgqqGYGN/8i88VIMTY2aTXoc
	5QWa5BrocjIUaRhu9/xom9noHmsUx1thJY5NXFDNZCT/+d+ZnvVKX61BQoDo+VVWcpdgxebSRDS
	QGP2hFZ8PhTj1blsSUyTXv/Zl3QOmJ7w=
X-Gm-Gg: AZuq6aLUW+qMAPaJCUqQpIP/WJ1vD0OcMS3m3CrK0Z8ygK34P91aEuCgNmQLybAIKax
	lz7WZeN2usnqQnli+uPZbE6itUbO5HIP9JQVxFFfaxuepbZLB4axb6RPj8JB0Y2b5PaCCI1ax4m
	+Hj3h3Y5zi7tQfUJp81o80Y9SbA7Fs4PyXMSRM8by31emrtPcik+7oSFsvdmFCjuwFBFT7PE4Xp
	kw3d8lbTi6W41V5ntLHjFxk8DPFrQ8YYoLUziHSCD2c9y/kiLrnZOYi6RsUxxrOwgMOw4KaUJfi
	Q3dNin0=
X-Received: by 2002:a05:6402:354e:b0:659:3cdb:5c4b with SMTP id
 4fb4d7f45d1cf-65a406a400amr203665a12.7.1770791256637; Tue, 10 Feb 2026
 22:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209163854.521415-1-dg573847474@gmail.com> <2c0395d5323770a32d53c6b874a735b888e4d4f1.camel@gmail.com>
In-Reply-To: <2c0395d5323770a32d53c6b874a735b888e4d4f1.camel@gmail.com>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Wed, 11 Feb 2026 14:27:25 +0800
X-Gm-Features: AZwV_QixYNCTTI7evf4eIWQM8dq-jZdP_XpviGeyic-zoD-G9ukyKfWGNW_Nb1Y
Message-ID: <CAAo+4rXAG0eeSN7B9c3R8YMxKe71hcNXccJSjrh1sF3VigQzNA@mail.gmail.com>
Subject: Re: [PATCH] fbnic: close fw_log race between users and teardown
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com, 
	lee@trager.us, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258203-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dg573847474@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E39B11219B4
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 1:24=E2=80=AFAM Alexander H Duyck
<alexander.duyck@gmail.com> wrote:
> A better fix for this might be to pull out fbnic_fw_log_enable/disable
> from the fw_log_init/free and leave them in the places currently
> occupied by the fw_log_init/free calls. With that we could place the
> log_init before the request_mbx call, add fw_log_free as an exception
> case before "free_irqs", and relocate fw_log_free to the line after the
> fw_free_mbx calls as it is a resource that should be put in place
> before the mailbox is enabled, and not cleared until after the mailbox
> and debugfs file has been disabled.

Looks great, adjusting the order of existing synchronization is much
better than adding new locking. I will send a new patch soon.

Thanks,
Chengfeng

