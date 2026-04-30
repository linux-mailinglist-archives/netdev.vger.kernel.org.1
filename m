Return-Path: <netdev+bounces-282948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NSkGqCI82mS4wEAu9opvQ
	(envelope-from <netdev+bounces-282948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:51:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1404A605A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01172300A7D3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11B33EB10;
	Thu, 30 Apr 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bz7WoQgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC69329C66
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567671; cv=pass; b=VkgI/vSxP9lBGffx9PcSqGIDIcRnHp3ov/76zXenAjag6O2QZOSlwBWhzeB4/LepZlAeUycfxBY1l7LaxuWE/5GQkuWYQfjEjQlGGtsVZEM1L3ki4iWFuzguM2IvCl/h6hpU+pCcdpzkmLB/kpcw72/0DiTJ7Pmpl60lVRoh99U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567671; c=relaxed/simple;
	bh=s3Q1zrVX/VDLpIIL3aJ8TT2PIigww+xEiCWav7Oc06s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pZM+sAF7YPW+gwsKpkg7AWP7vW30x3hGkN7NXXX7BSY2zpCoNOVkD9KVUr6rZh2N2QJvxtwgAHeok/NBfcEiquskuKLZxC1WZgTIdHK8GKW9wnW5oHqwx1AoTh9w1yqDuecxb99jGT4OCsdTYYI0/1StvO4KYOWjOJfLaL+qE7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bz7WoQgz; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso114a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777567669; cv=none;
        d=google.com; s=arc-20240605;
        b=D4Y6xGGulv8990rysjOsIL8WtJ7R31cNrNpZq4YJpu0Vy2A8EmvqwEgKZIUkDVKfHy
         rpP0zUAE6MnvBopynfXQdMl30bKpcb7NDOU0pHozV3l/7Bpl5hCZWqXNkya14nLedGE3
         9xhx5uUe/VvN2oCaoWqGAmaFHf8SuhfjKNjOpknTOVswgrOXOOP5FK8g4e9Qk0pwx+t7
         QQr0ru81ZuoLiLLSptjQ/F3M4rpjqVFVA/iL6c3SJFFzXX2U6ODjWpRFcP+kWm9QPkj8
         gieRTWxBADJ0ECmxq40yH5f3aD/xWdZH1OZhyz1QM5hu7Q1czAOhPi9APjTRyFUv+49E
         9VlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=35BOGIcH1p4dwQ5HuRv3TZ7eqiagtXX5VFCur+zr67U=;
        fh=lcRP/JuPI2Spal4BmJvxgAwMGUrJv8zlG+SD2pE6xAs=;
        b=BpHdiIVvlvDTswfjcihPo/qUrvM7aSyS6so6mlqEujBTbv26BeBofjAMnehHhs1XnY
         XfLgISUiJwg0q0RCCNRDan29JEUa3My4fIJPm5mzlsU6k+jNLz0nWXq/hrT4DGORZxES
         VcKHqdUt7YUSi+G56pQRWvS/J9uqjr1Mk0uXe+EwflaZZv2A78TiywOaIszOp4zjvihb
         1r9bPTqijVK5Le6ybDS1Tzsc8WXGdfMRMBPhSbEHf7+j20DJEf7696gV3GtlKYPh6BZX
         i/S+t9V+zkvXRUrj/RKCGcR7N+Nuu19U4zQ1zO0ahWALtw85s8kLKue7WF/51BtIryXx
         u1qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777567669; x=1778172469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=35BOGIcH1p4dwQ5HuRv3TZ7eqiagtXX5VFCur+zr67U=;
        b=Bz7WoQgzDd+nfWMklgOLBjaChHrou7f8kejh2HF1GUTZZOqQnhfro6oRPb34+QcALk
         Hi5kMoA/74+sDdm1OpY21gUhlE32cL7wN2fW4nP4H7S/SsIQAGFR17USFgib2oqy/+UI
         1owckaM2LHZZ5n6Qf23z7yEIX0YtiXCAmw2VYt+1tG8z+7t7gib23vJ5jkPk1DnncdWy
         cGn471zA2h0IW15horCWO3Gutq8yaURrim3D2AedDBMMGbJmWJnRABg8OpbxtSR7O5NH
         XW1MKl7omJSoQqnFhzDZY3pSzCX4saKqXoqmh9152CXR3BipjVgI0iA8KKSEepTUdz7w
         kp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567669; x=1778172469;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35BOGIcH1p4dwQ5HuRv3TZ7eqiagtXX5VFCur+zr67U=;
        b=ddoQw7mTgXq6mOh5ORdZdgYqXduFLm4O0MjSMnDY4XeoOJ0+Jwy1PLDlTNC5U+BmeJ
         RelH/X+PP0gQta23E8tyT66ALUDVqbFdB5si+o3K8soR38g5ASIt9RTJ8L7uP8WEVoDO
         OL8OduuRJbgk/9+6G8m65Hy6k9cZzyNblCiYaiiMaOd1FFEnkaRi0JrFXZpb0wtg4N78
         jpoNRK2A0HTAf3rmscpOO4R/llQHTN1lQA9cH7MVxv41SUuS74KvsQSpAB/Y9YGg3E2e
         JoXmk/o31RNekHNoOA/vJE6bSOwIUZTfDQBzCXToh6tzmjKJkyuLxlx5A5zzxvULC09P
         97VQ==
X-Forwarded-Encrypted: i=1; AFNElJ+enRlwMHkO5lKl5+qTyiE3TJGyaszeT7gZHx0xKf0qTc1ms5xEbMcYfuAxDHpLgH+qJGhLwi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UptUH8/NrckUPX+A/I1fbsNdrGksC6RYIq6pcmBnkVx3cS5n
	0xMiwgqKt0iu15/UXIxZ76L0d7IhwYSMBdUAJK8PRcJs2g+EEY4IRO5myEOwgqBGxBVksH82Szb
	kIvRfmLHcf0EL2gBhCkGoEcNO8dCL86Kkarcte+gj
X-Gm-Gg: AeBDietK/NumNWA9YA20aDqger5CQgW6TAEs+RMN1t+vS2xMmbldpdzItf7KqWI4gJc
	f/d6hQ0iu1u6XkAfwrDmntjHMH1NfFS2NrHSS7PM8FYIKYTpNUvfCGxUxh60w7v+B9TXa6gLhbn
	nDpliclYgm/L2QHKjzIxgLUKRdsUtoMEreJiO8avvJxc+3kfY+fgQGpwgDWuGJ1J3a3MlWXfxx5
	EyMuz1ioTZSFnKpBbf5oaREzomn+qpwyl/8vG8QCoRAEYGy/jF0Lb5lVr2sQGolVX1ZyIunnZPk
	gIh33dlkJ7UgII6Vfb6Svnm0l5SrstZNpwGqQFDWcsZFLVu22FRQlpE0Kw==
X-Received: by 2002:aa7:ca4c:0:b0:670:d5f0:2595 with SMTP id
 4fb4d7f45d1cf-67b8f250163mr2117a12.11.1777567668262; Thu, 30 Apr 2026
 09:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Apr 2026 18:47:12 +0200
X-Gm-Features: AVHnY4JtB2QrcIoj5b2LdRvNFl6PvvqV-cmLqetEfIthcxa1hOmyqbxeD9zj4A8
Message-ID: <CAG48ez2=SSQfGUXTPs9jQw_2Tw0JdzRHcLDdCgC7wTGkK0GOTA@mail.gmail.com>
Subject: [BUG?] bluetooth LE ISO sockets never get freed because of SOCK_DEAD confusion?
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BD1404A605A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282948-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

I can't figure out how to release a bluetooth LE ISO socket such that
it gets freed.

ISO sockets are placed on the iso_sk_list, which holds references to
its entries. The only place in which an ISO socket can be removed from
this list is iso_sock_kill(), which calls bt_sock_unlink(&iso_sk_list,
sk).

But iso_sock_kill() bails out immediately if either sk->sk_socket is
still set, or SOCK_DEAD is set. This means that if anything other than
iso_sock_kill() sets SOCK_DEAD, the socket can never be freed.

When I call close() on an ISO socket returned by accept(), the
behavior I observe is:

sock_close
  __sock_release
    iso_sock_release
      iso_sock_close
        iso_sock_kill
          [bails out because sk->sk_socket is still non-NULL]
      sock_orphan
        sk_set_flag(sk, SOCK_DEAD)
        sk_set_socket(sk, NULL)
      iso_sock_kill
        [bails out because SOCK_DEAD is now set]

Am I missing something, or can ISO sockets (once they have been
accepted) never be freed?

