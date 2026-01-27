Return-Path: <netdev+bounces-253873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFAoHC2+eGn6sgEAu9opvQ
	(envelope-from <netdev+bounces-253873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:31:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CC94ED4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8043300D914
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480821CC60;
	Tue, 27 Jan 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kb1P04h8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188721D3CA
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520683; cv=pass; b=uGpeTbNIgHMvllyZN+zb5ow10+QME8r9tk5spOxPLMhdtse4Fx299oLiQeWjC1zfDyJQRkzEJG78AB1M4kqmxSRYUqO7yqK0w0Jitxvjvq936BTVTK9l4qmXYkIc8tbttIDwAfxd1xVoNsIgSBoVLrR6U6nCLuBf7/bp1Y2yln0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520683; c=relaxed/simple;
	bh=+r3G/QHJoExy5LHByRUINoNhsXwNwWWFjxi07TX7dV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzmazQ/1P449fniqRqyjuL4Bw7PP3yMmSJdBA3dbHnW3ocVMel/ESEZzG7gcw9mio0sfzlkYl7CT4IGZRPv1CAgP+xHc0NULZd5eZtm/MFGoMBVzYdJSOv95DmN+KgI0zq5KIbMim+TPJTiAA8Cv7w7Gm/7BkI69+k2fb4xrw+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kb1P04h8; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-894a2309a29so25623066d6.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:31:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769520680; cv=none;
        d=google.com; s=arc-20240605;
        b=KRDSAGnm1zbAkR3S/pJK33wA6/p8YypB6O3AuugwLq/SEfRJbcJV5jtxSILV/Z7PXe
         US0hAWL8C2bN5kfYKwz29Uf1dtgFMOyHayG0LiFGS0OmF8sBZDNclT4UV3pQYb4KmNrN
         n1dvhmBTp9FK6jWt9l7V50ZGPyHCfTFtalAsPCT0ezoFcqZc8bxuW5FmmHYICgQeGpzf
         m6K8hJAFD8V/oWmBs8ZIPSEKdCz+RezeThi54EjubVS71ALPjUgkzxSzKGMM6k+ZEPcf
         V7H/2cuev8VcTq/i8aZyUkOgIGt6e5yuZwIj+HaN5/I7wTPKUC2pJlcj313JTyw5pK/K
         b2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fl2Etn/2oG0y77unhYEOvmf9UieR2eBeir7wEgQKw6U=;
        fh=dTkEppmstFSzceW8pCl9OmUL2Q0vAzN14R32s7kt4yE=;
        b=DCQAGKStcaD8ikwyodeKZnJ8jEfcvf0IhKRT8JJgf7IqYdHiA5GSuLzP5oJ/jNvz9r
         EDgEUfclI0GqaKVaGbqCnG2HxQFzZ7ryGuCUYZLue4HkU1dbYH2Dixnbn6pqcYlPxY0Z
         KneNdatrqwL+UrbIH2pvvXFzekdH4Jvg3oGYMEJgekwMVNPB/yA/8XrsV1DmXNgfWBr8
         gwXJaz7as7Z2we0OJjZZReOt22PeddSWW418G86b11d9if/dNsHdxLqmD6O6pYaToCjI
         wCu7RatcwoTQHaz0JHg0DANN4RMIx3PvVnlp7a8Myaq/vDnd6K4frPU9V1fPkRMzLMV2
         eQow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769520680; x=1770125480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl2Etn/2oG0y77unhYEOvmf9UieR2eBeir7wEgQKw6U=;
        b=kb1P04h8cw1DnD3BtEk/EpUMHPsWa2IaYHuU6hzwyAslN4yJTWFF7aw91K1fe4HHjs
         fM2dh13/oAzSIvfgI4BrgHlUW+CGcn+mH6R5wAFUw8T9VSqPcCMu495rEB+4OVE1gfG5
         Ogs1l5meGnet1KqJXvtds634peoMsj/D+MOmiBChJ4fE4hIgpeOjj3Ro//mX3BtTF6qt
         k4t7jF1JDv9St4zsnmjDzpaLSCDTaCp83xLh0gJ6DhEl7RSGI5vvuVWF/csAV1O1rEN2
         PDToSnPZqa6Y5AaAunhb1+NZS0bRspkMUHvAt+T46Y0MY/pQ2MPvyrYhTxWB8fJeHZJ3
         l5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769520680; x=1770125480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fl2Etn/2oG0y77unhYEOvmf9UieR2eBeir7wEgQKw6U=;
        b=bTBcIhOS8zeQBWYsmypCquqKqOzhkNgEIrd1hHlFFhHFdXbwKF9qPRrBwpd83nDG7L
         7LsX4NCiJXvSk1B1XIukF8atJfNEyBNoDrhbAvxLBfVZBDe+M+nDk2Qp5xAVZMu/mZm5
         4fWCsgIaCD9e2W1gkvV6ChPNzobvMXwgS0jELECAJqQ4UsV7JM5+m7v7rfVm9q3oP3J9
         asjNdppjCTrf8A4XN7MK9CXNGlx5HOmqIxtsG4DA72/uRc6oB+n0HzmTjs//9oqmm+B/
         7Fty4WSvECQO9Q8q2/qPpsALTKEnmv3FknK2/9m0HIu2s9CQd0OE9u+6nrOQBH6vYMUK
         5zDg==
X-Forwarded-Encrypted: i=1; AJvYcCVh4qzBBwRrNiacRY97jC3l9mZw5RJhfNAi97qTllHWphxZFobq8C8k7JKR/WIUWtv4Nn39Ml8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9vnPRVpI8QqTbe7ANnR8vLKCyxWTzerXvJpfqPil/oqN4y2p
	NNONtuuntoDthGKVF5xGFxeqC7LyhPBknKwydYg5LCODO93af6UEkrwZJh1lKr3teznNzqKsEkd
	XsDiwtL1t8XQnQtxln878h474eOkA8HSylnKX+Gsg
X-Gm-Gg: AZuq6aJOx9XUmkFB4ffMcuF1tnVyOv6d1DPbcqiVOIkzfGCn9me3AnzYXnElG6M+CEh
	Rs0YuWUm785wVGelDSbsV3QorR5rt2mkHlK2tiKX/nFGki+m7M8LH+jE8SMnqVartEcxA47E/xO
	ItNRAA7YnsZEfWxFxNSR82ByDq/CrGN2PjJ8hWzVXS3rrK2r3uKiiJ5wIGJdR5ylry1DEv6ATch
	tTKD+QOsbrpJFLESG3XjRuMLPmE6bF+I3YcY0evHV9xFtlJLyYCvR8WwipL8QDg9LycNEI=
X-Received: by 2002:a05:622a:301:b0:502:a1c6:3487 with SMTP id
 d75a77b69052e-50330067e29mr12205591cf.1.1769520680094; Tue, 27 Jan 2026
 05:31:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
 <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com>
 <CANn89iJrXSHouF4ZnnoVYz4Q47J5jkwU4OuXMpJi3Orox4uT_Q@mail.gmail.com>
 <CANn89iJvj8YXtuMNTh1cQOjVctBsMs88FHx-xLn+rCzyBGn-og@mail.gmail.com>
 <CAGfirfebdHJi13epyM5RWYfQ2TGSWExP5nmnoKra83awetAbLQ@mail.gmail.com>
 <CANn89iLhXQ0W7+rOQCqxLpGyoHBAJ_xeUhjL+7MtQmN2saaYog@mail.gmail.com>
 <CAM0EoMm49+9j77Xpb46Q7qVT7JBU2cXKZB-Oeurzsuoe-=3eJw@mail.gmail.com>
 <CANn89iL1oB2J6whubYof+2AVWpWRm+gBsp3P8-xRP8Y22Jy6_w@mail.gmail.com>
 <CAM0EoMnwGW05yc50ZyoKE28F-jZHeEtX+X4H2Xx6+KBQn-v6DQ@mail.gmail.com> <CAGfirfcWbnW0wMYSZNs4M5Hj-qPn1edJsDq9Y-4yxuBvOMzdWQ@mail.gmail.com>
In-Reply-To: <CAGfirfcWbnW0wMYSZNs4M5Hj-qPn1edJsDq9Y-4yxuBvOMzdWQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Jan 2026 14:31:08 +0100
X-Gm-Features: AZwV_QjVDlKptrI48VaolF5N0HWjrywNs-SYP7mMTjK_uwQdv4ojiUI72Bngslk
Message-ID: <CANn89iJkyUZ=mAzLzC4GdcAgLuPnUoivdLaOs6B9rq5_erj76w@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: GangMin Kim <km.kim1503@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net, jiri@resnulli.us, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, horms@kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253873-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mojatatu.com,davemloft.net,resnulli.us,kernel.org,vger.kernel.org,redhat.com,gmail.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BD1CC94ED4
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:48=E2=80=AFAM GangMin Kim <km.kim1503@gmail.com>=
 wrote:
>
> Structured the patch following similar commits to prevent out-of-bounds a=
ccess.
>
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -111,6 +111,17 @@ static inline unsigned int u32_hash_fold(__be32 key,
>   return h;
>  }
>
> +static bool offset_valid(struct sk_buff *skb, int offset)
> +{
> + if (offset > 0 && offset > skb->len)
> + return false;
> +
> + if (offset < 0 && -offset > skb_headroom(skb))
> + return false;
> +
> + return true;
> +}
> +

We need a formal patch :)

I will prepare a series on top of a generic helper, I am sure we
should use it elsewhere

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d4a8452e90fe78adcdcfdefb79169..72679aa7af587cad524feba8243=
2154cfb8afbd3
100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4301,6 +4301,18 @@ skb_header_pointer(const struct sk_buff *skb,
int offset, int len, void *buffer)
                                    skb_headlen(skb), buffer);
 }

+/* Variant of skb_header_pointer() where @offset is user-controlled
+ * and potentially negative.
+ */
+static inline void * __must_check
+skb_header_pointer_careful(const struct sk_buff *skb, int offset,
+                          int len, void *buffer)
+{
+       if (unlikely(offset < 0 && -offset > skb_headlen(skb)))
+               return NULL;
+       return skb_header_pointer(skb, offset, len, buffer);
+}
+
 static inline void * __must_check
 skb_pointer_if_linear(const struct sk_buff *skb, int offset, int len)
 {

