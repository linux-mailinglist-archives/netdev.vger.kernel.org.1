Return-Path: <netdev+bounces-263252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCSzG873pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:01:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CF01F1F08
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB4630810B7
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2A47DFBE;
	Tue,  3 Mar 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWFnVb+S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35247DD7C;
	Tue,  3 Mar 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549594; cv=none; b=Wg7FYIxkiyGoB1tIXigReYOeNJeOxJuDr7Xe8E0u8ULrPfdqM+YmFkQvPwRrZC5XBD21eoGhObIgGyMvQtjf6iZdMgwZnKbO1Vx0yU+ALlrINJ3cnXgJFrTtPq0BL5+UkkMXr3xHkSFKP3mCByMYf4tPPFjV/W9Nt1iuE3dTuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549594; c=relaxed/simple;
	bh=mPB+8jSnehbEHKBNReaI36+tVxnO/gz5hMo6CDtR1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JY949EHxhGh5rrgkp7RhEVZwOMaPfDBjIlm2tx6a/sKzvySqvxSxobuLYRJZeAEear/Wn6EsHM/7SoR1zOCa/EY/iRQv2C9Ei0yomOlIDFYn66NIZ2+/yTphAfnDeVexSRmMb9jm9qf0j7UH+/sBYurAOkylpR5PRqL3qC7WEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWFnVb+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D73C19422;
	Tue,  3 Mar 2026 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772549594;
	bh=mPB+8jSnehbEHKBNReaI36+tVxnO/gz5hMo6CDtR1vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IWFnVb+SAOFAW6k2lmD7xM2MmjXDlaKtuLQfi1BOXrrQ730APm7WOFiF67wuUnc++
	 EGSzMenoInTEUWIO7CSSf/bFBl4ZeUXZjL85avoqiMtQK/oSff46KbycV28M9WkDvY
	 XUnahFU9ulGTN30W+mMw/EMqmtkIduKav8WJUB/2TDsOz+bW+urOzRV9Fi1DNqM4ee
	 y8ZD8ab8w73Luic7Ff60S0bNdLT8kqI7mAwcYvulxf5n9Crzb9z2+s2S3vi5j4rpkZ
	 kPzV3aBM8fN2nX5iOYorO3X9cnpTBIe8tlimk92fP+EUrdxUrMwniVlPpd88G7WOWL
	 5SvNPVQd6C1oA==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vxR7W-00000007JR5-48Lo;
	Tue, 03 Mar 2026 15:53:11 +0100
Date: Tue, 3 Mar 2026 15:53:10 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
Message-ID: <20260303155310.5235b367@localhost>
In-Reply-To: <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
	<33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 07CF01F1F08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263252-lists,netdev=lfdr.de,huawei];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,python.org:url]
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 15:47:00 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Wed, 18 Feb 2026, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > As anyone that worked before with kernel-doc are aware, using regex to
> > handle C input is not great. Instead, we need something closer to how
> > C statements and declarations are handled.
> >
> > Yet, to avoid breaking  docs, I avoided touching the regex-based algorithms
> > inside it with one exception: struct_group logic was using very complex
> > regexes that are incompatible with Python internal "re" module.
> >
> > So, I came up with a different approach: NestedMatch. The logic inside
> > it is meant to properly handle brackets, square brackets and parenthesis,
> > which is closer to what C lexical parser does. On that time, I added
> > a TODO about the need to extend that.  
> 
> There's always the question, if you're putting a lot of effort into
> making kernel-doc closer to an actual C parser, why not put all that
> effort into using and adapting to, you know, an actual C parser?

Playing with this idea, it is not that hard to write an actual C
parser - or at least a tokenizer. There is already an example of it
at:

	https://docs.python.org/3/library/re.html

I did a quick implementation, and it seems to be able to do its job:

    $ ./tokenizer.py ./include/net/netlink.h
      1:  0  COMMENT       '/* SPDX-License-Identifier: GPL-2.0 */'
      2:  0  CPP           '#ifndef'
      2:  8  ID            '__NET_NETLINK_H'
      3:  0  CPP           '#define'
      3:  8  ID            '__NET_NETLINK_H'
      5:  0  CPP           '#include'
      5:  9  OP            '<'
      5: 10  ID            'linux'
      5: 15  OP            '/'
      5: 16  ID            'types'
      5: 21  PUNC          '.'
      5: 22  ID            'h'
      5: 23  OP            '>'
      6:  0  CPP           '#include'
      6:  9  OP            '<'
      6: 10  ID            'linux'
      6: 15  OP            '/'
      6: 16  ID            'netlink'
      6: 23  PUNC          '.'
      6: 24  ID            'h'
      6: 25  OP            '>'
      7:  0  CPP           '#include'
      7:  9  OP            '<'
      7: 10  ID            'linux'
      7: 15  OP            '/'
      7: 16  ID            'jiffies'
      7: 23  PUNC          '.'
      7: 24  ID            'h'
      7: 25  OP            '>'
      8:  0  CPP           '#include'
      8:  9  OP            '<'
      8: 10  ID            'linux'
      8: 15  OP            '/'
      8: 16  ID            'in6'
...
     12:  1  COMMENT       '/**\n  * Standard attribute types to specify validation policy\n  */'
     13:  0  ENUM          'enum'
     13:  5  PUNC          '{'
     14:  1  ID            'NLA_UNSPEC'
     14: 11  PUNC          ','
     15:  1  ID            'NLA_U8'
     15:  7  PUNC          ','
     16:  1  ID            'NLA_U16'
     16:  8  PUNC          ','
     17:  1  ID            'NLA_U32'
     17:  8  PUNC          ','
     18:  1  ID            'NLA_U64'
     18:  8  PUNC          ','
     19:  1  ID            'NLA_STRING'
     19: 11  PUNC          ','
     20:  1  ID            'NLA_FLAG'
...
     41:  0  STRUCT        'struct'
     41:  7  ID            'netlink_range_validation'
     41: 32  PUNC          '{'
     42:  1  ID            'u64'
     42:  5  ID            'min'
     42:  8  PUNC          ','
     42: 10  ID            'max'
     42: 13  PUNC          ';'
     43:  0  PUNC          '}'
     43:  1  PUNC          ';'
     45:  0  STRUCT        'struct'
     45:  7  ID            'netlink_range_validation_signed'
     45: 39  PUNC          '{'
     46:  1  ID            's64'
     46:  5  ID            'min'
     46:  8  PUNC          ','
     46: 10  ID            'max'
     46: 13  PUNC          ';'
     47:  0  PUNC          '}'
     47:  1  PUNC          ';'
     49:  0  ENUM          'enum'
     49:  5  ID            'nla_policy_validation'
     49: 27  PUNC          '{'
     50:  1  ID            'NLA_VALIDATE_NONE'
     50: 18  PUNC          ','
     51:  1  ID            'NLA_VALIDATE_RANGE'
     51: 19  PUNC          ','
     52:  1  ID            'NLA_VALIDATE_RANGE_WARN_TOO_LONG'
     52: 33  PUNC          ','
     53:  1  ID            'NLA_VALIDATE_MIN'
     53: 17  PUNC          ','
     54:  1  ID            'NLA_VALIDATE_MAX'
     54: 17  PUNC          ','
     55:  1  ID            'NLA_VALIDATE_MASK'
     55: 18  PUNC          ','
     56:  1  ID            'NLA_VALIDATE_RANGE_PTR'
     56: 23  PUNC          ','
     57:  1  ID            'NLA_VALIDATE_FUNCTION'
     57: 22  PUNC          ','
     58:  0  PUNC          '}'
     58:  1  PUNC          ';'

It sounds doable to use it, and, at least on this example, it
properly picked the IDs.

On the other hand, using it would require lots of changes at
kernel-doc. So, I guess I'll add a tokenizer to kernel-doc, but
we should likely start using it gradually.

Maybe starting with NestedSearch and with public/private
comment handling (which is currently half-broken).

As a reference, the above was generated with the code below,
which was based on the Python re documentation.

Comments?

---

One side note: right now, we're not using typing at kernel-doc,
nor really following a proper coding style.

I wanted to use it during the conversion, and place consts in
uppercase, as this is currently the best practices, but doing
it while converting from Perl were very annoying. So, I opted
to make things simpler. Now that we have it coded, perhaps it
is time to define a coding style and apply it to kernel-doc.

-- 
Thanks,
Mauro

#!/usr/bin/env python3

import sys
import re

class Token():
    def __init__(self, type, value, line, column):
        self.type = type
        self.value = value
        self.line = line
        self.column = column

class CTokenizer():
    C_KEYWORDS = {
        "struct", "union", "enum",
    }

    TOKEN_LIST = [
        ("COMMENT", r"//[^\n]*|/\*[\s\S]*?\*/"),

        ("STRING",  r'"(?:\\.|[^"\\])*"'),
        ("CHAR",    r"'(?:\\.|[^'\\])'"),

        ("NUMBER",  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
                    r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),

        ("ID",      r"[A-Za-z_][A-Za-z0-9_]*"),

        ("OP",      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
                    r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:"),

        ("PUNC",    r"[;,\.\[\]\(\)\{\}]"),

        ("CPP",     r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)"),

        ("HASH",    r"#"),

        ("NEWLINE", r"\n"),

        ("SKIP",    r"[\s]+"),

        ("MISMATCH",r"."),
    ]

    def __init__(self):
        re_tokens = []

        for name, pattern in self.TOKEN_LIST:
            re_tokens.append(f"(?P<{name}>{pattern})")

        self.re_scanner = re.compile("|".join(re_tokens),
                                     re.MULTILINE | re.DOTALL)

    def tokenize(self, code):
        # Handle continuation lines
        code = re.sub(r"\\\n", "", code)

        line_num = 1
        line_start = 0

        for match in self.re_scanner.finditer(code):
            kind   = match.lastgroup
            value  = match.group()
            column = match.start() - line_start

            if kind == "NEWLINE":
                line_start = match.end()
                line_num += 1
                continue

            if kind in {"SKIP"}:
                continue

            if kind == "MISMATCH":
                raise RuntimeError(f"Unexpected character {value!r} on line {line_num}")

            if kind == "ID" and value in self.C_KEYWORDS:
                kind = value.upper()

            # For all other tokens we keep the raw string value
            yield Token(kind, value, line_num, column)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} <fname>")
        sys.exit(1)

    fname = sys.argv[1]

    try:
        with open(fname, 'r', encoding='utf-8') as file:
            sample = file.read()
    except FileNotFoundError:
        print(f"Error: The file '{fname}' was not found.")
        sys.exit(1)
    except Exception as e:
        print(f"An error occurred while reading the file: {str(e)}")
        sys.exit(1)

    print(f"Tokens from {fname}:")

    for tok in CTokenizer().tokenize(sample):
        print(f"{tok.line:3d}:{tok.column:3d}  {tok.type:12}  {tok.value!r}")


