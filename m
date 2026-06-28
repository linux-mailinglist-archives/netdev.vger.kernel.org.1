Return-Path: <netdev+bounces-302387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZJvLMZwGQWo9kQkAu9opvQ
	(envelope-from <netdev+bounces-302387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E006D3AFD
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:33:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JpKJajIp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302387-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302387-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25DF3300CC02
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459F35201C;
	Sun, 28 Jun 2026 11:33:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5E15E8B
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 11:33:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646425; cv=pass; b=r73ZUI7gNtY+trWuXnD/8JnHPmbaNB0okIuMjaAp6lQrr+eqFX1bmskYMNpgILwCIR5Qpe3Bzs6DH7shjVPFAKHmFBbRVE8JEHxUm0UZHfxIrUt6KGMXLFs/V9O4oo9hbPQBlaI1MAM7SN0+QOk0+mup6yp8aEH2RPx/zKRW7F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646425; c=relaxed/simple;
	bh=bgfpN079ZTjkfGSzvnJl3HzKuIyjV75/HikjUo6F6JI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ku2GSMhauJuuwMVxMOQCfWVKTT9SbTWxRen50A8witgL+z/LcU7J5gwCRVGaa//YfB+hWEOnuZ0mkIWBb3EBw1U0Iimsg51UywRSMDzbT/BBtdWEhhy0CVa6+9RzhmCQhkoY+nt9lQP6sAcD281zNj/6CTI0Qw/CPjTa9so/Yyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpKJajIp; arc=pass smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-471eeac43bfso887295f8f.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 04:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782646423; cv=none;
        d=google.com; s=arc-20260327;
        b=XX85SfQ0eBpMOJofT88n6StlH1aUAK8u7REXKK/+K0HZ5BMPIhiz5ewLn14CSskhDN
         5dXcjNSrgSZdjusRE+n1P389e8/oLd1gcmg66vR5Pw1BquQEaMUu4iGIHgSy2nmwP/Sk
         aF6pHXhIgdsj22j0xrt37NRwo38vB0tREkNOdYkHFWuuu4TO6UeVXF3XpNm5EcJfqMPP
         piAY2z9a7Z+1S9OHARFRsfRUziqWRbSEyje+Wq0gLv9foL3K7EyJgXRGyJ3kyvaNYxsD
         V68qjgfB05BJXjKqb4Uls52muBfgZas/gFEy3rkO7qm3ilg+geln834FY+GPVLeDfgBH
         Cmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        fh=8MK+xCPUZSuaN4/lOJfMiXVqCtQCUbgNI2CFLqxGkcg=;
        b=rUiR5C/mCX8zWv6/zY8ykX3lvZwAVnipGasUObUvnlESSk9Whrxf8JmfsHNIfq4nOj
         ChQmCuq7ynHXE6vTPwYeTDDe+rSQyG22HYpxSEFDOfHImHM3Pv8LNwkaNdB8V/+C3ddH
         bW0yhFdW+/I1lfHIBmMvNWfxxkDqePOANKi2tqaYhvx7N/Lo3bqdSfe5Me/D0vkaqShV
         YlB01GmZJG0hqMhpgGGe9bqkOJ5cjslapjLZQ2FD15w3c1qNPxSQ9saShBgZUg/oP39i
         wVmxV70M3ML9l7f1F3z8nAjcO81US+hJWg2NVxY7Gfvx5uycyaHizzO2PomQvBRc66G7
         tttg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646423; x=1783251223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        b=JpKJajIpQ0FsXQUjKhtdpT3iBJKQSG165IVyQXjfxsUhliJGJNWIPAZTUBpR89tEn6
         H2KbKu0pdQJMavGl9T4mRFD/AnmSdewRUk61h87UCuGx7In2VcJLio1PRkbCtBR/gmJ8
         Jbdbd6rkYcCrmaU0jrWq2dffI6HzdULitCNKmdw71Ro4f+P7KW65jPC6eYhMsg16G9bi
         lEPGfBk6RLrg7yrhNP/+rQTuBXYVbo1kur2+03a1gHnXiOTxPSjF+Z7PUuuhQjpmkHIY
         j7BFIP4K70FYuyYgqCiKysNbGPq2eNwB9tY80qeecK8s+Xvd+6ZZtqDg1MfC6SRgXkQw
         K3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646423; x=1783251223;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBSQ7Q9WGiOFkEauFRc+1+ZNzSO1tr4SWnVeYuWVixE=;
        b=QQFJMQMxTWhezIy+egNiLkfGWd6n36BWqoKIWtnVfKR0Yfp6J2chX0Ddml2iScjU/z
         AybHsd1t7ww70lfKTx1v18fAlhrtfwap3jxOgsNAABgFpGrhvMxutq/MxIxzOZGuBci+
         xnBVq4vWiKKDXALMoq4LWgPu0NYCu8HhGX4SV6tGfus5xm4cff4adsov6sKgFFMBJALO
         u/Ju9259gsQne5SwwQFQfGGriBCciuSbg3/JzRTsIzn8cQXkCLo5ibv3XW6YWtOgxl88
         s3pD9S0wvc7zNBzHiRbQgRCsYVJLIBShxq3Go5jFoXcrr4I6afg2kuLs40PzDvpMtZEw
         JT7A==
X-Gm-Message-State: AOJu0YwaSTzg63UaaIyh1LfkkUV5+/APw569VgCbDsMv/Tz0c4RIR6N/
	KtyIkVBGtJZ8Nsv3txQoLFrQKsJqTWVajDh6TYa2mvRVU4vt9zX+8RY0xklnBUpG4dQwjLQwiLQ
	BAKFfiekQ9B53nhVdn8m6RfOg2XfVZREf0eHkZJs=
X-Gm-Gg: AfdE7cl1vIcH34xfzOeJJCc2Th72KWIVkEusvCZ0HoR0ST9hF/rYxIe7FLYgyV6ZtdK
	5kNDUDDUMJ+EVJzsGHOu99mzsxVq45EIDebB2rPm75S1YL1rgdf+xVCq20D3SjVL/wJ8UFvlbSO
	kASikBw0I07qQtK+5/Yj+7VEVy0ZWIfYylxkq/rOw/3n+ckik1uyqFi5+5M4Urtuq2EJnv05SLf
	ywWv4MRh9A3xAs1yfeCd6qazGhjCyLkWQaFFzszKPC3YODtu/coMqoXa6uwCey/BTgLXw==
X-Received: by 2002:a05:6000:3111:b0:45e:f684:7347 with SMTP id
 ffacd0b85a97d-46dbf7d1bc0mr22070830f8f.12.1782646422449; Sun, 28 Jun 2026
 04:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 28 Jun 2026 20:33:31 +0900
X-Gm-Features: AVVi8Ceiv0d_3j-P-e81X83o_swUGxL0tFzZtYhSLjCxBgrq_DUpuk-krqAYxbI
Message-ID: <CAFk-A4mcCfNBWLw-rMAnC25k8LV6fF2_jGyhpKciFZv35koy8w@mail.gmail.com>
Subject: xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: leon.hwang@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302387-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[masashihonma@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:leon.hwang@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14E006D3AFD

Hello,

The bpf_xdp_link_attach_failed tracepoint (added in commit bf4ea1d0b2cb
"xdp: Add tracepoint for xdp attaching failure") exposes the netlink
extack message produced when attaching an XDP program via BPF_LINK_CREATE
fails. This is useful because, unlike the netlink attach path, the
bpf_link attach path does not return the extack to userspace -- the caller
only gets an errno (e.g. EINVAL/ERANGE).

We would like to use this in Cilium [1][2]: when attaching the XDP
datapath program fails, surface the kernel's reason (e.g. "single-buffer
XDP requires MTU less than ...") in the agent logs instead of an opaque
errno, so operators don't have to inspect dmesg on the host.

The limitation we hit is that the tracepoint only carries the message
string, so a consumer cannot tell which device a failure belongs to.
This matters for two reasons:

  1. Correlation: with only the message, a consumer cannot reliably
      attribute a failure to a specific attach, particularly if multiple
      XDP attaches happen concurrently.
  2. Scoping: a consumer watching this tracepoint sees XDP attach
      failures system-wide and cannot limit them to the devices it
      manages.

At the call site (bpf_xdp_link_attach() in net/core/dev.c) the net_device
is in scope, so exposing it looks straightforward:

  TRACE_EVENT(bpf_xdp_link_attach_failed,
      TP_PROTO(const char *msg, const struct net_device *dev),
      TP_ARGS(msg, dev),
      TP_STRUCT__entry(
          __string(msg, msg)
          __field(int, ifindex)
      ),
      TP_fast_assign(
          __assign_str(msg);
          __entry->ifindex = dev->ifindex;
      ),
      TP_printk("ifindex=%d errmsg=%s", __entry->ifindex, __get_str(msg))
  );

  - trace_bpf_xdp_link_attach_failed(extack._msg);
  + trace_bpf_xdp_link_attach_failed(extack._msg, dev);

Before sending a formal patch I'd appreciate guidance on a few points:

  - Should the tracepoint take const struct net_device *dev (consistent
    with the other tracepoints in this file, and lets TP_printk show the
    device), or just the ifindex as an int (simpler for raw_tp BPF
    consumers, which otherwise read dev->ifindex via CO-RE)?

  - For raw_tp consumers the argument order is effectively ABI: prepending
    dev would shift the existing msg argument. I've appended dev above to
    keep msg at args[0]. Is preserving the existing argument position the
    right call, or is reordering acceptable given how new and rarely
    consumed this tracepoint is?

  - Is extending the existing tracepoint preferred, or would you rather
    keep it as-is and expose the device context some other way?

This would be my first XDP/BPF tracepoint change, so any direction is
welcome. I'm happy to send a proper patch once the shape is agreed.

Regards,
Masashi Honma

[1] https://github.com/cilium/cilium/issues/40777
[2] https://github.com/cilium/cilium/pull/46546

