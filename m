Return-Path: <netdev+bounces-253941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II1vCwzqeGmHtwEAu9opvQ
	(envelope-from <netdev+bounces-253941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:38:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B1597D9A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2ECA301907D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2875E3009E8;
	Tue, 27 Jan 2026 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBykhWjM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1224293C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531912; cv=pass; b=NN279NcsJjsQ3n2nw5TUMbfrKTQFe7oCr+RHHZupCYRGOJdnhPbMVR4TXfmmmaCEX1CGasK0Xw/DPpCyp639KuDkeIAp5PwQcDZdCELFzdBOBVO9p4pVuU3G4RX4gxZAh8Rgsm/bXqLazj2WkkQERhFb09vzOnCc9l2zfaWiyiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531912; c=relaxed/simple;
	bh=kL96nXAEiZdouPMV9c7TqdKeCACwqohru8JEmnEYS0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+kHRDaIqqeLcKiyBqyWYLVKvbPJV9EN6rZx8/EDqGEAsCQf2GH/fNO4FAInW+AmiWNrnbDcM39pipL2Zw1mdxdCp9GU77PQfqqVXNJI94uVvl3e7JudDgQydA+N+k86Tw0n5K8RiUxHxcpaSPFjjr6KzwAXIsEXV/SHzYI3ZB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBykhWjM; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014e1312c6so37575271cf.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 08:38:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769531909; cv=none;
        d=google.com; s=arc-20240605;
        b=K5KEB1agHn4unrP07r0p0R/7Jv7Gl7fETRAi6DFY7sMdL8bJ2mcMbTVgQMCQt90Twz
         r3z3sndCA0vYtZIizol75DSL3CHcXx82Pup3xIWUUUkY9gr5PADm1nMkkZm+jqCzQwt8
         SjMNmEJfcEF1GrmIgoCFyoUoZg5Ylyp/evDZckygqo5boIeI3ii8EjoeWHO284QpWfEs
         8sf+8pCKzCTxGbvCczV/W51mE7of7Bae1hPTuh8xFcgLb2A2/1KNjaUeBVPoS6jJpgJJ
         om84IkOvKJH2+lrYwGaCxdxNBB5t/K3xgry/NKUJ1nTaGqvDYC3EaBaOVzaDeqgKOK3G
         8BBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kL96nXAEiZdouPMV9c7TqdKeCACwqohru8JEmnEYS0c=;
        fh=GHj4fiG0kJSmi6dfCsh2tyGhtcd3+QhY8mQTiQP3Hms=;
        b=Wk5Ofd+L+r9rrIUXbBURtG9x2KvAARzraRTuH1DwbAocpB+E6CH6VzFJioZ6/OGSgN
         BGJMw2406d3O9KrKdbt4VwqtB/gzYiI0h7rUYs2LghwxzTo8aqB4nXh1+Y1s1IgJsNpt
         RvlgWBnaHb0DOrUwOIpF8PbWuPwYJxXWhiHWW1D5UVHCL87pnUVzHQHmMDbIotzWKJ6d
         zlf9mPTzT/uwEECIJz+044GUx/G9Fy3S/z3tdO9tXB/Hh+N/TRnKdOG1z4m/fzY+U5ak
         pvtyx9Hp1YeX5cDGiNh+EhoZOqKrmc5GiKm+/gbbfMDYKe4goY1ar6WaPfQYnqNkpXM7
         cMJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769531909; x=1770136709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL96nXAEiZdouPMV9c7TqdKeCACwqohru8JEmnEYS0c=;
        b=EBykhWjMUt0AEu6Tm9BCP43D8ZThvr8W35iWlWijvLQvujCcyMTTBAJiGvakd8PkHY
         BFtGZzZa48wZLvCuEnldEYnl+RR4paP8/W9h8yp75TMAEHZLVhr7nHKmcBupgLoLCXc5
         QwvB8wR2JEY9Y+bj7vWf0KmCvzjsKSRP3BGMhKwujCMeUHazygk9L4pXyO6nM/bMz1Jx
         A/UxvixqWbH9ySNvK/dDPcmzsmYcDwsjtKtMtUVstGCsgQE2QiE/F7arNVc6H1ENZEN2
         x6l1xZgsoj5n7pvRlRQEdFx6SyzLyOpjGP8Z3OXYgQ1l6EtOBNPh3xJFV1Ohl86n402x
         fOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769531909; x=1770136709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kL96nXAEiZdouPMV9c7TqdKeCACwqohru8JEmnEYS0c=;
        b=UHMcdoflKGLcoV82fRSIB6LcKA3MtaD/eTzVIS2ESknw6x2aweOsuIbRWhK5zK4vWM
         tUQN3luanKTU9XgjgtH2XCufFNxYimlaA5dFerYkv3a+rwikAi+Unia5w+WCS4E6e2Zv
         ribpSqMuZnnEctSLgJSMJCL1R7O4pvfIraaM5EWeHNsziQTWA0MISfZQ8dJeb54wZMr+
         j9GA75UE3Z3U4k9LXTH0o00ArGFZwJDDa2a/CU8sQn9P7pBeL7wRnX8U4GqV2anbNYvG
         odq7f3QR8PfwxX2Z0RSgpy3DxDWomzL5Tx7LlqBMJi28fLxvL4uYvgYe95kwVmgX+6aA
         /htA==
X-Forwarded-Encrypted: i=1; AJvYcCVOYZW6VAXyTmAoD+bzn6nzr8TAirYkQMK00zgkk8Wv1miDjP9cwZPErkk/YuY74JqudckGlUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb22kWyWVUykUR2QXnCgX1Wkq7X/LKZBX1fw7jrdWj0LLM+BJH
	BiPW05UBnVaZsaG6qnSIa8zijO10srC0shMmhmxW8XlCDFb+8vcZWmJ17JftVk30T9cezffJh2o
	Ip5db/lXkcDoM5bM7qsiFIFPbF+ZYEYlYrMaTbmyi
X-Gm-Gg: AZuq6aJ0QiUk+faM8DJggehNR4UTCoQdUD4p8IpGBKfwClhAaIplRlmUc/xhcBnySDi
	AcLEn0BFvRQhNcxtA4umHDKGr39chXxnz/VrUkP442VOEIrneOIuMRvb0G2mT7ByW5Ww1lQ/tci
	N4EU6/s2ZTBTXNVEH4IUeaeb7eHXoDUuh06paul3CydY+D+jXC2J1g+It3rQtbEeI8rl3tNrRfB
	0gyZ55BmbBu8n1F4OGXwJuMM062FlHT6rlPRiMCrfyXbGnjYeHoNOh/9x8zrp8pXT7L9t4=
X-Received: by 2002:ac8:5dd1:0:b0:4ee:2352:1bb2 with SMTP id
 d75a77b69052e-5032f74b38dmr26711201cf.11.1769531909141; Tue, 27 Jan 2026
 08:38:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126215600.3387171-1-brianvv@google.com>
In-Reply-To: <20260126215600.3387171-1-brianvv@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Jan 2026 17:38:16 +0100
X-Gm-Features: AZwV_QjhIhpxeKUJvscd4k--3JPHyzfLDcHYRzyDNv5IO3bTmn-ulVh-ULL49RQ
Message-ID: <CANn89i+ioEJFnZF3B36xGXcCPgtiLevZOs9pncXhgLKb80sm_g@mail.gmail.com>
Subject: Re: [iwl-net PATCH v3] idpf: change IRQ naming to match netdev and
 ethtool queue numbering
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Brett Creeley <brett.creeley@amd.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253941-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,davemloft.net,kernel.org,redhat.com,lists.osuosl.org,google.com,vger.kernel.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 53B1597D9A
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:56=E2=80=AFPM Brian Vazquez <brianvv@google.com>=
 wrote:
>
> The code uses the vidx for the IRQ name but that doesn't match ethtool
> reporting nor netdev naming, this makes it hard to tune the device and
> associate queues with IRQs. Sequentially requesting irqs starting from
> '0' makes the output consistent.
>
> This commit changes the interrupt numbering but preserves the name
> format, maintaining ABI compatibility. Existing tools relying on the old
> numbering are already non-functional, as they lack a useful correlation
> to the interrupts.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

