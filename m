Return-Path: <netdev+bounces-301659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W/O2LafaO2rzeAgAu9opvQ
	(envelope-from <netdev+bounces-301659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:24:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC26BE927
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:24:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=cgCrq7NG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301659-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB133301AB92
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995A73B6BFD;
	Wed, 24 Jun 2026 13:23:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871C3B5E01
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 13:23:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307406; cv=none; b=Yb/eMcS2Vg75pL99Ay4EyhdNc/n5bUFsQvOUEdKzyEjpusY9qxmQrA9jDKltDYcQ7XlpxoSMv5uZUpw56G6NSSrPfW7zKYAaR94Q2NwkmHlrl1tbs8SLkbBsPVv4WdccsIomO4tQcfLgApgthq7r3gd6hF8zuKj87eby//Gguqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307406; c=relaxed/simple;
	bh=nOGI1wI+vpa0w8/Vtce1TwCsycM2v5+pG5SNHLWaxXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmgDQbfKDA92AkAlrdMsQxfWi2i05zJvfnZQfJiJIwtOla8ZUfOJEr6U1yUJnSVg2Am+fG1Ql2izEOzYvvnFTtW012BIzWVLTGJW3gIa8j01peAAILNItFakYFpx1ixnECeWXOgKJRRC2WnMp8ovFxTlm5kiVK4Y/hMmvgwidsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cgCrq7NG; arc=none smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso158622266b.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782307401; x=1782912201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcv3i8MxYGcE66nrV/kv3D5y9IOE8aUQHBcOTbfUFU4=;
        b=cgCrq7NGG1p0s3yNJZX9a278VP+kx23StqMr2I8tXonWrDsYnISG5dIsC6qk7Uktc2
         XLunBxsVzP1gxhwR2nQvA90HP2RjR2M9FgYY9DSuiLrzvk6fsfdn0LWScB2xSSnwfQDi
         v8R0W+ObgUgIdywLlvB6Ksnki2hBo6ScvAQqgWh7u5IW8crEsW93sq9e8vpdKTYxbXO5
         oSpBX3P45oikv1Y4B6xCJKqfYnxKeRsMOj4VhHh/AMDnMGroAUGKEw0dbbK674Jrillk
         eeEbLOaqP9SZijhcjbaCyCEx0vYr+Np3sq/WmLVv9PAVJnuVhBf9mptydGoMPKthnC9M
         aelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307401; x=1782912201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcv3i8MxYGcE66nrV/kv3D5y9IOE8aUQHBcOTbfUFU4=;
        b=F7XXTzsEnyeIeY+y86lq+mNloEf8w9fx7Vd6fk7SerCyjMBPCLdCq2y9kLkAFvImrt
         la+KNgjOvVoYusVJVhv9RuUfZTdVmQN0WRoROsavCtGYMtLcqiqZBoyHGDJoX0xakDyG
         OKl478efQITHBtbrWBXly+qceOl+cTv1VDVkAedXO5e+5tSFAW8g5SzWbTEFJPb868Za
         BZkQYzv9w1O0ahBNjTxQ1b+/kvXCkNL8MQ1kz02igwKT+IoquYAuYw2qZWuP6nTsG+7E
         26FA2bAWDf2pIv0vy5CQJ8n+ajwfv5WeUOscF+i9Qj95Pc+abWjDWNuk2b1IYBvilSFf
         j3gg==
X-Forwarded-Encrypted: i=1; AFNElJ/FsqesoDWHdHApK2BRQswj/1ODO5tg693T0yqsRM4OOMaQ4kkGU4h9m5PqKcIJXrBJ22OBS3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiv+9JA2TGI8tveKE5uplZ7UxHu34OqiL3HW6usidu0IVJDjWE
	8t57cFAVs2aeMr0ATxqDQL1Xltp3LiIOg1YAJIt8coGgfPsx6Oi1DRBBekkiM3bH+8w=
X-Gm-Gg: AfdE7ck6vpnK4DRzthHkavOMjrO4+G4a4VUW1IHtt7di7St+e5jSAMa/Hj2KzoBw/j7
	YYPbVN6ilUm5zpLemBmWJ5tuj+OLlAoIFMtnknH+xV/IX8gtiLCzTSwFzrs3iY/8VeXc68r3M+V
	9kH9e2Tc2eBFdz3Hwz9j2kWja7NuqtNsYjhHbDyZbOXAoxCAP2ttxRyFLGu6VM/lRFSVFpN9NpG
	V72uLH0PojlIQw/1EW44M7OkFduQX/w17eFvogWvgBD2bBE6BbnoHxMvJ/37blDcDprgsFiN5Nr
	FLx7Dr098spmLchTskZUuEWalJ9XoBKQQz5Y9QCu4LgIaJSubWbBx82yprxreLOGG1M2C3N8bTN
	7vzRDWirVe0ReQa4BQxRDTxh+O8/NDGw6HTLcNJtdQANOsBmYeG1CtUGqv/jTAad45if4zxKKYY
	Su4snMeo4BEf3L2aHxFrgPkZYhmIAs+YNMXCW6E4WMu/aY8UdiN1nEYq8CrkhA35wc3h37urjyI
	1inlPZ6svqH1LV6kkmyl2EbtUIH3ivcXrjP7OiOEyPpIo7xVykZXBGCToo=
X-Received: by 2002:a17:907:a807:b0:c10:d41c:e540 with SMTP id a640c23a62f3a-c119e179685mr185363566b.11.1782307400601;
        Wed, 24 Jun 2026 06:23:20 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99e1aasm644551166b.25.2026.06.24.06.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:23:20 -0700 (PDT)
Message-ID: <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
Date: Wed, 24 Jun 2026 15:23:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[46];
	TAGGED_FROM(0.00)[bounces-301659-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alvin.sun@linux.dev,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@
 googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,linux.dev,davidgow.net,debian.org,kernel.dk,intel.com,android.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,googlegroups.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4ECC26BE927

On 6/24/26 2:57 PM, Alvin Sun wrote:
> During tyr debugfs development, a kernel NULL pointer dereference was
> encountered after `rmmod tyr` while gnome-shell still held /dev/card1 open:
> 
> ```
>   [158827.868132] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   [158827.868918] Mem abort info:
>   [158827.869177]   ESR = 0x0000000086000004
>   [158827.869519]   EC = 0x21: IABT (current EL), IL = 32 bits
>   [158827.870000]   SET = 0, FnV = 0
>   [158827.870281]   EA = 0, S1PTW = 0
>   [158827.870571]   FSC = 0x04: level 0 translation fault
>   [158827.871043] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108dec000
>   [158827.871623] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>   [158827.872242] Internal error: Oops: 0000000086000004 [#1]  SMP
>   [158827.872246] Modules linked in: tyr sunrpc snd_soc_simple_card rk805_pwrkey snd_soc_simple_card_utils rtw88_8822bu display_connector rtw88_usb rtw88_8822b snd_soc_rockchip_i2s_tdm snd_soc_hdmi_codec
>   rtw88_core]
>   [158827.872337] CPU: 4 UID: 1000 PID: 11276 Comm: gnome-s:disk$0 Tainted: G                 N  7.1.0-rc1+ #331 PREEMPT
>   [158827.880534] Tainted: [N]=TEST
>   [158827.880535] Hardware name: FriendlyElec NanoPi R6C/NanoPi R6C, BIOS v1.1 04/09/2025
>   [158827.880538] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   [158827.880542] pc : 0x0
>   [158827.880547] lr : _RNvNtCs257m05FHVbX_3tyr2vm8pt_unmap+0x8c/0x12c [tyr]
>   [158827.880578] sp : ffff800083c236b0
>   [158827.880579] x29: ffff800083c236d0 x28: ffff00013f8a0000 x27: 0000000000000000
>   [158827.880585] x26: 000000000000007c x25: ffff000108e6ed80 x24: 0000000000401000
>   [158827.880590] x23: 0000000000000000 x22: 0000000040000000 x21: 0000000000001000
>   [158827.880595] x20: ffff00010f778138 x19: 0000000000400000 x18: 00000000ffffffff
>   [158827.880600] x17: 000000040044ffff x16: 045000f2b5503510 x15: 0720072007200720
>   [158827.880606] x14: 0720072007200720 x13: 0000000000401000 x12: 0000000000400000
>   [158827.880611] x11: ffff800083c239d0 x10: ffff000141e4fd88 x9 : 0000000000000000
>   [158827.880615] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000400000
>   [158827.880620] x5 : ffff00013f8a0000 x4 : 0000000000000000 x3 : 0000000000000001
>   [158827.880625] x2 : 0000000000001000 x1 : 0000000000400000 x0 : ffff00010f778138
>   [158827.880630] Call trace:
>   [158827.880632]  0x0 (P)
>   [158827.880635]  _RNvXs6_NtCs257m05FHVbX_3tyr2vmNtB5_9GpuVmDataNtNtNtCsgmSOfgXi5CZ_6kernel3drm5gpuvm11DriverGpuVm13sm_step_unmap+0x3c/0x120 [tyr]
>   [158827.891166]  _RNvMs4_NtNtNtCsgmSOfgXi5CZ_6kernel3drm5gpuvm6sm_opsINtB7_5GpuVmNtNtCs257m05FHVbX_3tyr2vm9GpuVmDataE13sm_step_unmapB13_+0x18/0x34 [tyr]
>   [158827.891187]  op_unmap_cb+0x78/0xb0
>   [158827.891196]  __drm_gpuvm_sm_unmap+0x18c/0x1b4
>   [158827.891204]  drm_gpuvm_sm_unmap+0x38/0x4c
>   [158827.891209]  _RNvMs5_NtCs257m05FHVbX_3tyr2vmNtB5_2Vm7exec_op+0x1cc/0x254 [tyr]
>   [158827.894085]  _RNvMs5_NtCs257m05FHVbX_3tyr2vmNtB5_2Vm11unmap_range+0x124/0x188 [tyr]
>   [158827.894105]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeNtNtCs257m05FHVbX_3tyr3gem8KernelBoEBK_+0x44/0xd8 [tyr]
>   [158827.894125]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeINtNtNtCsgmSOfgXi5CZ_6kernel5alloc4kvec3VecNtNtCs257m05FHVbX_3tyr2fw7SectionNtNtBL_9allocator7KmallocEEB1r_+0x3c/0x100 [tyr]
>   [158827.894147]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeINtNtNtCsgmSOfgXi5CZ_6kernel4sync3arc3ArcNtNtCs257m05FHVbX_3tyr2fw8FirmwareEEB1p_+0x94/0x190 [tyr]
>   [158827.894167]  _RNvMs4_NtNtCsgmSOfgXi5CZ_6kernel3drm6deviceINtB5_6DeviceNtNtCs257m05FHVbX_3tyr6driver12TyrDrmDriverE7releaseBW_+0x30/0x98 [tyr]
>   [158827.899550]  drm_dev_put.part.0+0x88/0xc0
>   [158827.899557]  drm_minor_release+0x18/0x28
>   [158827.899562]  drm_release+0x144/0x170
>   [158827.899567]  __fput+0xe4/0x30c
>   [158827.899573]  ____fput+0x14/0x20
>   [158827.899579]  task_work_run+0x7c/0xe8
>   [158827.899586]  do_exit+0x2a8/0xac4
>   [158827.899590]  do_group_exit+0x34/0x90
>   [158827.899594]  get_signal+0xaac/0xabc
>   [158827.899599]  arch_do_signal_or_restart+0x90/0x3e8
>   [158827.899606]  exit_to_user_mode_loop+0x140/0x1d0
>   [158827.899613]  el0_svc+0x2f4/0x2f8
>   [158827.899620]  el0t_64_sync_handler+0xa0/0xe4
>   [158827.899627]  el0t_64_sync+0x198/0x19c
>   [158827.899632] ---[ end trace 0000000000000000 ]---
> ```
> 
> The root cause: `fops.owner` was `NULL` in Rust DRM drivers, so the kernel
> never blocked module unloading while file descriptors were open. This leads to
> use-after-free when drm_release (or other fops) is called on freed module code.
> 
> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, threads it
> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates configfs
> and rnull to use `this_module::<LocalModule>()`.

I cannot comment that much on all the details of the Rust
implementation, but the series looks reasonable to me from the modules
perspective. I'm glad this issue will be finally addressed.

I would only suggest adding the new file rust/kernel/module.rs in
patch #1 under the MODULE SUPPORT support entry in the MAINTAINERS file,
similarly to the other module-related Rust code, so that the module
maintainers are emailed when changes to this file are proposed. I think
you can change the existing 'F: rust/kernel/module_param.rs' to
'F: rust/kernel/module*.rs'.

-- 
Thanks,
Petr

