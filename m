Return-Path: <netdev+bounces-266699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AePOSSZsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:32:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB622267665
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA4203029C25
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73F33D4F2;
	Wed, 11 Mar 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxMd0jf7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48136EA82
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246747; cv=pass; b=GjxxdkWMo8a0xYWnu0NFByEmA9n2sbBWgb7/r+nGWSVMuz9jd5aiGdaI41ENOsabI7g28DcCIGve1+U9+0T3qb1zoLDNzSW9Iw0PO4hU45DAOUWL1gz76mfh3LLrpOA+uJscej9hdE+Uu7ulBOs5/wnprbe0NozCiJKKIucgu5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246747; c=relaxed/simple;
	bh=Cw6jyFi5YAUQ4ksZRMvarA0YK+iWTnpDQdfa/UGuCNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Afl5NzosWWKN0y0tJB0lso1xAvmCKPPDA7Ve+nbdnbtJfpWTLfjn44++JtdkI6j16UIQkcmjmfSzaHXRxMWINPHVLXebWglYMDTa2HFMKXDGjCqRMCiG3apCE1BnKNszGrd/UVXH2EU+WBtEEDh9vmGbM6GtoQhGbzpwmbKrrHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxMd0jf7; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59de8155501so129574e87.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773246742; cv=none;
        d=google.com; s=arc-20240605;
        b=VGjMntEnIjYA3Xujg6eC2wlHIYft4l5XM02QGB/H/cRfmCWhZzm5rh7qslufMnxziq
         pWdWxps+J/YaWhKSaXr1QIebPquzrd3isW9eWwLVSrywcb7bcSYTHqT0Ku6ehTKhJ9hG
         Ejfd9+/oHBlUZn/zmwPsVR+PdeypDfc+ZqipIqBR1kLjB21e8CLFM8jrahIYAu7Hls2+
         mB+QCTHZVostKZbGE55IaGwXi9IiDmW1VS20tsq1rcurMkY4/5q6Cp54cSMJsgC+kVlm
         EqJ+4nRsMvf0ffbjijf6X2RGHeftzDX9IwISZG+98CK00GNunhDc+6JUZ0Zgn/8k3i0T
         RSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RdYEyi4BsLrTGQ/I8fgZVCPrBr5stN8KGZ4ouLYLEg=;
        fh=0BvesE64gRBqCvmwtuBFL+awioruVAOUF0XAxVyVXNo=;
        b=W6GViKTUsmGzLoTlgZNwyuLh6wjvPCpZtFWvC5386v5I7HwSnSc3sSAaFKbxiH08ZM
         m37gUECX0HTZEgmOMJBwW8a8sFi2/hZGidMj1wIsOHbZgqqrai2aHlmOzO0Jqitqim/H
         9WRRn14sMHuezkWUy59NXASFhr7PXhjh7AgYCq+2xP+lwhMtTJT+UF+mQyAx/08l1QVj
         yi1vhfwoiRN40zx7hBzwCHIau0+yuBbxlZfy8EG4D7ZtKhnxdVYOzydMdib7SCLLVKdm
         ruC3stKTuNAyIktdtcjMktufzoLp2s2r8lZ05ZT9HNHn39Z1VWI6+UUjYhZczcAsVVfa
         VU1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773246742; x=1773851542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RdYEyi4BsLrTGQ/I8fgZVCPrBr5stN8KGZ4ouLYLEg=;
        b=YxMd0jf7T1Bhxl8nQS/fLA5ZJa8nrjM1RTj+zh16A//O5D7QHoH1UV+e35s7qQZMuw
         dRzBVJUmDEyf2moxhudvsjLMATqZ2rYZ6k/RtU2xjvY8QZn0Fswj5lSMS5YGj5zLJ9Gz
         dSaKOuZ9VZ5VgFW0m6DYrTtObKJpeJlH3TAirFmAUL3Q1UzcbPLY+7SrAEwpOHbcUol2
         7U4JDGgscizm8dT9EzXxH3MeUy/Uho4R+xjbeEoqMw8dwJuN4x0nsI8Ek+L6Cj/wihP6
         u9vC/cEWRnl9LdIsHgPerfoMr98PF6Q0CGRJ/1KgCbrNEpKO08NAI0fKNTB8XO3AzCTI
         Q3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773246742; x=1773851542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RdYEyi4BsLrTGQ/I8fgZVCPrBr5stN8KGZ4ouLYLEg=;
        b=junueXOaBAzYhDu53PKO7QjcXTzPwV+WRvn2tzf8bI8WBthJq4BRez5PXCNwpTLXXO
         UwBtwjBIZMT/220YJ6s0Gs9GvX1n0qAJqmO/TTicooCPR6TpH2/rrlpVJoyNb80dC2ja
         A0LBoO3TkJUGLYgODgpencDS9D/ZgMgRL8+5ontBaPcHkwsO9uCDzT6hZBx8albKEIO9
         4/3ah9y2C+lotH4/BFw0N9XAtjwLqP9DcCEcFIYfcGZlWCpFx1gjJcRb7AuMsZ1hru0c
         pPVDOBqbRLf53cJ4CmkevV+tjDa+aqU+GT5+g83B/O6lYM2iq01+uAPdtmnppu3SYrGq
         evsw==
X-Forwarded-Encrypted: i=1; AJvYcCU6FUZ/fEo6aJfC+ag0jA+5IJZ6fMJBgz1BqfWCmHiTaS0ZptRhg1HCg043ug/WPA/zOCcNa5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjKCBrp6/BqF/iaMqqTbpdzrTqkSHFx9LclbmtIXQW40SzSrT
	ZNdtEzO8HBehdTuPjnfjX27TAwb+k3Jm5gxbbIJ74Oa9xQzV7MgKfSkSZcU77oQRZZES71olqzQ
	LbiG5H4gzrDtD+BoaBfin54O0knxSxy8=
X-Gm-Gg: ATEYQzyLEgxuWLBn3L6rdjMzYS5nsgC3VIJnNNNgfa4mpQdM+4ptg/VRd6gwWqz0R/w
	/u987bNYCRl6+guGioWxGMy1p0P1OFtIAZh3PPI429OfexMJAieVCOmzytl65vYCo7HmMxG2Xel
	fPN9HFs9+fxfjGy/Micjx7BEKsHsniweOXoU8wBnU/RYaXVXrm6IguRUNXTdzVsyYbQ8z3NgUL5
	W/+XxL4+9muF94fAPVEIlu2PkLmTlSHIoQx1Oc34FkYcXHSc47oPh9s5wA+KJ+hz0wejo32IORk
	lNamGX5idPOybg/0XUW554vPg2GVZ8UTqZSMDafJvXd3W/b6d+4Eulf6A743YgKA5FMdskSqBev
	ugbR83mxRHF0OlzVW2WBXQ0Pqa80Tk5YXpnM=
X-Received: by 2002:a2e:ab0d:0:b0:38a:6acc:85f with SMTP id
 38308e7fff4ca-38a6acc4ff5mr10626211fa.36.1773246741810; Wed, 11 Mar 2026
 09:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309122055.1226507-1-edumazet@google.com> <20260309134355.GC606826@noisy.programming.kicks-ass.net>
 <CANn89iJTw1Wu8jOGuvGKnWixo86LSRXNzgKkj2A=csrYvj9KfQ@mail.gmail.com>
 <CANn89i+7Pqf9pdZtic3kesKakv9+5TOgfWSce=M065wNmaBHsg@mail.gmail.com>
 <CANn89iKyPZUqmirYza5ewD2dBQfZCMunG771x7cMpUFkvw9x9w@mail.gmail.com> <20260311155539.3Aikrlaz@linutronix.de>
In-Reply-To: <20260311155539.3Aikrlaz@linutronix.de>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 11 Mar 2026 17:32:08 +0100
X-Gm-Features: AaiRm53hDMLHNJnpc1oSH-UVl-hMhwBtwgOTf8-9AG8X2D4IIgn9tpSubPjC_x8
Message-ID: <CAFULd4aGZ4HcUYcXJ=5LYkyNtJ=0fHFbk-ZEvotpd=+CF3F1JA@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Reduce local_[un]lock_nested_bh() overhead
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Marco Elver <elver@google.com>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266699-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,infradead.org,linutronix.de,vger.kernel.org,gmail.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AB622267665
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 4:55=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-03-09 15:52:34 [+0100], Eric Dumazet wrote:
> > > +void ericeric(void);
> > > +void ericeric(void)
> > > +{
> > > +       raw_cpu_read_long(this_cpu_off);
> > > +       raw_cpu_read_long(this_cpu_off);
> > > +}
> > >
> > > I am guessing __raw_cpu_read() is forcing the asm ?
> >
> > Might be a clang issue. Oh well.
>
> So the difference is that with gcc we have USE_X86_SEG_SUPPORT and with
> llvm we don't. This leads to two asm statements with LLVM of which only
> one is eliminated. This optimisation origins in commit ca4256348660c
> ("x86/percpu: Use C for percpu read/write accessors").
>
> __seg_fs and __seg_gs is supported by LLVM but enabling it leads to tons
> warnings and aborts later.

Tons of warnings is just due to clang being picky and warns for
duplicated qualifiers, such as "__seg_gs __seg_gs var". This can be
fixed with:

https://lore.kernel.org/lkml/20240526175655.227798-1-ubizjak@gmail.com/

> Is there something missing in LLVM? The generated code for
> raw_cpu_read_long(this_cpu_off) looks fine.

Yes:

1. The %fs: and %gs: prefix does not get emitted in inline assembly.

2. An internal compiler error when addressing symbols directly:
https://github.com/llvm/llvm-project/issues/93449

3. Wrong named address space for anonymous struct:
https://github.com/llvm/llvm-project/issues/119705

Uros.

